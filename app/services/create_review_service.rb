# frozen_string_literal: true

class CreateReviewService < BaseService
  attr_reader :result

  def initialize(request_params:, client:, current_user:)
    @request_params = request_params
    @client = client
    @current_user = current_user
  end

  def run!
    # NOTE: reviewデータとの関連付けのため必要なデータを保存
    # TODO: mediatorにして、このクラスで保存している処理を分離する
    upsert_spotify_data

    album = Album.find_by(spotify_id: @request_params.album_id)
    review = @current_user.reviews.build(
      title: @request_params.title,
      text: @request_params.text,
      rating: @request_params.rating,
      album_id: album.id
    )

    @result = OpenStruct.new(
      saved_result: review.save ? true : false,
      album_id: album.spotify_id
    )
  end

  private

  def upsert_spotify_data
    ActiveRecord::Base.transaction do
      return if Album.exists?(spotify_id: @request_params.album_id)

      album = @client.get_album(spotifies_album_id: @request_params.album_id)
      artists = album.artists.map { |artist| generate_artist(artist) }

      result = Artist.import! artists, on_duplicate_key_update: {
        conflict_target: %i(spotify_id),
        columns: %i(name image external_urls)
      }

      generated_album = generate_album(album, result.ids)
      album.tracks.each { |track| build_song(generated_album, track) }

      Album.import! [generated_album], recursive: true, on_duplicate_key_update: {
        conflict_target: %i(spotify_id),
        columns: %i(name image release_date external_urls)
      }
    end
  end

  def generate_artist(artist)
    Artist.new(
      name: artist.name,
      image: artist.images.first["url"],
      external_urls: artist.external_urls["spotify"],
      spotify_id: artist.id
    )
  end

  def generate_album(album, artist_ids)
    Album.new(
      name: album.name,
      release_date: album.release_date,
      external_urls: album.external_urls["spotify"],
      image: album.images.empty? ? Constants::DEFAULT_IMG_URL : album.images.first["url"],
      spotify_id: album.id,
      artist_ids: artist_ids
    )
  end

  def build_song(album, track)
    album.songs.build(
      name: track.name,
      track_number: track.track_number,
      preview_url: track.preview_url,
      disc_number: track.disc_number
    )
  end
end
