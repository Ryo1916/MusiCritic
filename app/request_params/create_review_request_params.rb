# frozen_string_literal: true

class CreateReviewRequestParams < BaseRequestParams
  attribute :title, :string
  attribute :text, :string
  attribute :rating, :float
  attribute :album_id, :string

  validates :title, :text, :album_id, presence: true
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  def initialize(params)
    super(
      params['review'].permit(:title, :text, :rating, :album_id)
    )
  end
end
