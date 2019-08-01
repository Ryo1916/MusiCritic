class ReviewsController < ApplicationController
  include Common

  before_action :authenticate_user!
  before_action :set_review, only: %i[edit update destroy]
  before_action :set_new_review, only: %i[create]
  before_action only: %i[edit create update destroy] do
    set_album(id: @review.album_id)
  end
  before_action only: %i[edit create update destory] do
    set_average_rating(album: @album)
  end

  def edit; end

  def create
    respond_to do |format|
      if @review.save
        format.html { redirect_to album_path(@album.spotify_id), notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render 'albums/show' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to album_path(@album.spotify_id), notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { redirect_to album_path(@album.spotify_id), alert: 'Unsuccessfully updated.' }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_new_review
    @review = Review.new(review_params)
  end

  def set_album(id:)
    @album = Album.find(id)
  end

  # FIXME: reviews/_formでhidden_fieldを使わないようにする
  def review_params
    params.require(:review).permit(:title, :rating, :text, :user_id, :album_id)
  end
end
