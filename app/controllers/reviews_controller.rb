# frozen_string_literal: true

class ReviewsController < ApplicationController
  include UserAccessable
  include ApiClientGeneratable

  rescue_from BaseRequestParams::InvalidRequestParams, with: :render_bad_request

  invisible_captcha only: %i[create update], honeypot: :subtitle

  before_action :authenticate_user!
  before_action :generate_spotify_client, only: %i[create]

  def create
    request_params = CreateReviewRequestParams.new(params)
    request_params.validate!
    service = CreateReviewService.new(request_params: request_params, client: @spotify_client, current_user: current_user)
    service.run!
    redirect_to album_path(result.album_id), notice: 'Review was successfully created.'
  end

  def update
    request_params = UpdateReviewRequestParams.new(params)
    request_params.validate!
    review = Review.find(request_params.id)
    review.update!(request_params.attributes)
    redirect_to request.referer, notice: 'Review was successfully updated.'
  end

  def destroy
    request_params = ReviewIdRequestParams.new(params)
    request_params.validate!
    review = Review.find(request_params.id)
    review.destroy!
    redirect_to request.referer, notice: 'Review was successfully destroyed.'
  end
end
