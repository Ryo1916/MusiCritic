class AlbumsController < ApplicationController
  include SpotifyAPI::V2::Client

  before_action :authenticate_user!
  before_action only: %i[show] do
    save_album(spotifies_album_id: params[:id])
  end
  before_action :set_album, only: %i[show destroy]

  def index
    @albums = new_releases(limit: Constants::NEW_RELEASE_ALBUMS)

    if album_name = params[:album_name]
      @albums = albums(album_name: album_name)
    end
  end

  def show
    @review = Review.new
    @reviews = @album.reviews.reviews_list(page: params[:page])

    if @reviews.blank?
      @avg_rating = 0
    else
      # @reviewsを@avg_ratingにセットすると、@reviewsにセットしたページネーションが邪魔してaverageが計算されない
      @avg_rating = @album.reviews.average(:rating).round(2)
    end
  end

  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_album
    @album = Album.find_by(spotify_id: params[:id])
  end

  # FIXME: models配下にPOROで独自モデルを定義して、そこで保存するように変更したい
  # FIXME: spotify側のデータ構造が変わった場合、新データとして保存されてしまう
  def save_album(spotifies_album_id:)
    return if Album.find_by(spotify_id: spotifies_album_id)
    unique_album = unique_album(spotifies_album_id: spotifies_album_id)

    # Artistの存在チェック／保存
    album_artists = unique_album.artists.map do |artist|
      # FIXME: album.artists = []の場合、unknown artistをセットしないとダメかも
      Artist.find_or_create_by(
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
        album_id: saved_album.id
      )
    end
  end
end
