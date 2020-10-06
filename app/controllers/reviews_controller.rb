class ReviewsController < ApplicationController
  include UserAccessable
  include ApiClientGeneratable

  before_action :authenticate_user!
  before_action :set_review, only: %i[update destroy]
  before_action :generate_spotify_client

  def create
    request_params = CreateReviewRequestParams.new(params)
    request_params.validate!
    service = CreateReviewService.new(request_params: request_params, client: @spotify_client, current_user: current_user)
    service.run!
    result = service.result
    respond_to { |format| result.saved_result ? format.html { redirect_to album_path(result.album_id), notice: 'Review was successfully created.' } : format.js }
  end

  def update
    respond_to do |format|
      @review.update(review_params) ? format.html { redirect_to request.referer, notice: 'Review was successfully updated.' } : format.js
    end
  end

  def destroy
    @review.destroy
    respond_to { |format| format.html { redirect_to request.referer, notice: 'Review was successfully destroyed.' } }
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :rating, :text)
  end
end
