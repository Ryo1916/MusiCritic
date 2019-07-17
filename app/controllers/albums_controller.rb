class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :destroy]
  before_action :authenticate_user!

  def index
    @albums = Album.albums_list(page: params[:page])
    if params[:album_name]
      # FIXME: 二回同一内容読んでしまっているので、リファクタリングできないか考える
      @albums = Album.search_album(album_name: params[:album_name], page: params[:page])

      # もしartistがDBに存在しない場合、albumを保存する前にAPIからデータ取得して保存する
      if @albums.empty?
        albums = Album.search_album_from_api(album_name: params[:album_name])
        albums.each do |album|
          album.artists.each do |artist|
            if Artist.find_by(name: artist.name).nil?
              artists = Artist.search_artist_from_api(artist_name: artist.name)
              Artist.save_artist(artists: artists, artist_name: artist.name)
            end
          end
        end
        Album.save_album(albums: albums, album_name: params[:album_name])
        @albums = Album.search_album(album_name: params[:album_name], page: params[:page])
      end
    end
  end

  def show
    @album = Album.find(params[:id])
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
      @album = Album.find(params[:id])
    end
end
