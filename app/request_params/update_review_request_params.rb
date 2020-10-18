# frozen_string_literal: true

class UpdateReviewRequestParams < BaseRequestParams
  attribute :id, :integer
  attribute :title, :string
  attribute :text, :string
  attribute :rating, :float

  validates :id, :title, :text, presence: true
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  def initialize(params)
    modified_params = modify_params(params)
    super(modified_params.permit(
      :id,
      :title,
      :text,
      :rating
    ))
  end

  private

  def modify_params(params)
    ActionController::Parameters.new(
      id: params['id'],
      title: params.dig(:review, :title),
      text: params.dig(:review, :text),
      rating: params.dig(:review, :rating)
    )
  end
end
