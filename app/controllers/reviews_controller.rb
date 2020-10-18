# frozen_string_literal: true

class ReviewsController < ApplicationController
  rescue_from BaseRequestParams::InvalidRequestParams, with: :render_bad_request

  include UserAccessable
  include ApiClientGeneratable

  before_action :authenticate_user!
  before_action :generate_spotify_client, only: %i[create]

  def create
    request_params = CreateReviewRequestParams.new(params)
    request_params.validate!
    service = CreateReviewService.new(request_params: request_params, client: @spotify_client, current_user: current_user)
    service.run!
    respond_to { |format| result.saved_result ? format.html { redirect_to album_path(result.album_id), notice: 'Review was successfully created.' } : format.js }
  end

  def update
    request_params = UpdateReviewRequestParams.new(params)
    request_params.validate!
    review = Review.find(request_params.id)
    result = review.update(request_params.attributes)
    respond_to { |format| result ? format.html { redirect_to request.referer, notice: 'Review was successfully updated.' } : format.js }
  end

  def destroy
    request_params = ReviewIdRequestParams.new(params)
    request_params.validate!
    review = Review.find(request_params.id)
    review.destroy
    redirect_to request.referer, notice: 'Review was successfully destroyed.'
  end
end
