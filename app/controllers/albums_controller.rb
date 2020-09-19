class AlbumsController < ApplicationController
  include Common

  before_action only: %i[show] do
    save_album(spotifies_album_id: params[:id])
  end
  before_action :set_album, only: %i[show destroy]
  before_action :set_top_rating_albums, only: %i[index show]

  def index
    @new_releases = SpotifyAPI::V2::Client.new_releases(limit: Constants::NEW_RELEASE_ALBUMS)
    if album_name = params[:album_name]
      if album_name.present?
        @albums = SpotifyAPI::V2::Client.albums(album_name: album_name)
      else
        respond_to do |format|
          format.html { render :index }
          flash.now[:alert] = 'Please enter album name.'
        end
      end
    end
  end

  def show
    @review = Review.new
    @reviews = @album.reviews.reviews_list(page: params[:page])
    @artists = SpotifyAPI::V2::Client.unique_album(spotifies_album_id: @album.spotify_id).artists
  end

  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
    end
  end

  private

  def set_album
    @album = Album.find_by(spotify_id: params[:id])
  end

  def set_top_rating_albums
    @top_rating_albums = Album.top_ratings(limit: Constants::TOP_RATING_ALBUMS)
  end

  # FIXME: models配下にPOROで独自モデルを定義して、そこで保存するように変更したい
  # FIXME: transactionを使う
  def save_album(spotifies_album_id:)
    return if Album.find_by(spotify_id: spotifies_album_id)
    unique_album = SpotifyAPI::V2::Client.unique_album(spotifies_album_id: spotifies_album_id)

    # Artistの存在チェック／保存
    album_artists = unique_album.artists.map do |artist|
      Artist.find_or_create_by!(
        name: artist.name,
        image: artist.images.first["url"],
        external_urls: artist.external_urls["spotify"],
        spotify_id: artist.id
      )
    end

    saved_album = Album.create!(
      name: unique_album.name,
      release_date: unique_album.release_date,
      external_urls: unique_album.external_urls["spotify"],
      image: unique_album.images.empty? ? Constants::DEFAULT_IMG_URL : unique_album.images.first["url"],
      spotify_id: unique_album.id,
      artists: album_artists
    )

    unique_album.tracks.each do |track|
      Song.create!(
        name: track.name,
        track_number: track.track_number,
        preview_url: track.preview_url,
        album: saved_album
      )
    end
  end
end
