class ReviewsController < ApplicationController
  include UserAccessable

  before_action :authenticate_user!
  before_action :set_review, only: %i[update destroy]
  before_action only: %i[update destroy] do
    set_album(id: @review.album_id)
  end

  def create
    @review = current_user.reviews.new(review_params)
    @album = Album.find(@review.album_id)

    respond_to do |format|
      if @review.save
        format.html { redirect_to album_path(@album.spotify_id), notice: 'Review was successfully created.' }
      else
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to request.referer, notice: 'Review was successfully updated.' }
      else
        format.js
      end
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Review was successfully destroyed.' }
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_album(id:)
    @album = Album.find(id)
  end

  def review_params
    params.require(:review).permit(:title, :rating, :text, :user_id, :album_id)
  end
end
