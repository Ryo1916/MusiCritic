class AlbumsController < ApplicationController
  include Search

  before_action :set_album, only: [:show, :destroy]
  before_action :authenticate_user!

  def index
    @albums = Album.albums_list(page: params[:page])
    if album_name = params[:album_name]
      @albums = Album
        .search_albums_from_spotify(album_name: album_name)
        .album_list(page: params[:page])
    end
  end

  def show
    @album = Album.find(params[:id])
    @review = Review.new
    @reviews = @album.reviews.order("created_at desc").page(params[:page]).per(Constants::REVIEWS_FOR_ALBUMS_SHOW_PAGE)
    # falseの場合に@reviewsを@avg_ratingにセットすると、@reviewsにセットしたページネーションが邪魔してaverageが計算されない
    # FIXME: マジックナンバー対応
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
