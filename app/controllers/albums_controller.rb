class AlbumsController < ApplicationController
  include SpotifyAPI::V2::Client

  before_action :authenticate_user!
  before_action only: %i[show] do
    save_spotify_data(spotifies_album_id: params[:id])
  end
  before_action :set_album, only: %i[show destroy]

  def index
    @albums = new_releases

    if album_name = params[:album_name]
      @albums = search_albums_from_spotify(album_name: album_name)
    end
  end

  def show
    @review = Review.new
    @reviews = @album.reviews.order("created_at desc").page(params[:page]).per(Constants::REVIEWS_FOR_ALBUMS_SHOW_PAGE)
    # falseの場合に@reviewsを@avg_ratingにセットすると、@reviewsにセットしたページネーションが邪魔してaverageが計算されない
    @reviews.blank? ? @avg_rating = 0 : @avg_rating = @album.reviews.average(:rating).round(2)
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
    # FIXME: reviewをcreateした後、params[:id]がAlbumのidになるので、ここでnilになってしまう。
    @album = Album.find_by(spotify_id: params[:id])
  end

  def save_spotify_data(spotifies_album_id:)
    return if Album.find_by(spotify_id: spotifies_album_id)
    unique_album = search_unique_album_from_spotify(spotifies_album_id: spotifies_album_id)

    # Artistの存在チェック／保存
    # FIXME: album.artists = []の場合、unknown artistをセットしないとダメかも
    album_artists = unique_album.artists.map do |artist|
      if Artist.find_by(spotify_id: artist.id)
        Artist.find_by(spotify_id: artist.id)
      else
        Artist.create!(
          name: artist.name,
          image: artist.images.first["url"],
          external_urls: artist.external_urls["spotify"],
          spotify_id: artist.id
        )
      end
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
