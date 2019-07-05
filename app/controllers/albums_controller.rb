class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :destroy]
  before_action :authenticate_user!

  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
    @reviews = Review.where(album_id: @album.id).order("created_at desc")

    if @reviews.blank?
      @avg_rating = 0
    else
      @avg_rating = @reviews.average(:rating).round(2)
      # average: tooutput average rating
      # round(2): round off to two decimal places
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
    @album = Album.find(params[:id])
  end
end
