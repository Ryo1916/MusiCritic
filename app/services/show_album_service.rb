# frozen_string_literal: true

class ShowAlbumService < BaseService
  attr_reader :result

  def initialize(request_params:, client:, page:)
    @request_params = request_params
    @client = client
    @page = page
  end

  def run!
    album_id = @request_params.id
    spotify_album = @client.get_album(spotifies_album_id: album_id)

    album = generate_album(spotify_album)
    artists = spotify_album.artists
    songs = spotify_album.tracks
    top_rating_albums = Album.preload(:artists)
                             .where.not(spotify_id: album_id)
                             .top_ratings(limit: Constants::TOP_RATING_ALBUMS)
    reviews = Review.eager_load(:user, :album)
                    .where(albums: { spotify_id: album_id })
                    .reviews_list(page: @page) # TODO: nilが渡される→そのあとでデフォルト値が設定されているかも

    @result = OpenStruct.new(
      album: album,
      top_rating_albums: top_rating_albums,
      artists: artists,
      songs: songs,
      reviews: reviews
    )
  end

  private

  def generate_album(album)
    # NOTE: spotify側とアプリ側のデータ構造の違いを吸収するため、albumオブジェクトに変換
    Album.find_or_initialize_by(
      name: album.name,
      image: album.images[0]['url'],
      release_date: album.release_date,
      external_urls: album.external_urls['spotify'],
      spotify_id: album.id
    )
  end
end
