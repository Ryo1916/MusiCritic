# frozen_string_literal: true

class CreateReviewRequestParams < BaseRequestParams
  attribute :title, :string
  attribute :text, :string
  attribute :rating, :float
  attribute :album_id, :string

  validates :title, :text, :rating, :album_id, presence: true

  def initialize(params)
    super(
      params['review'].permit(:title, :text, :rating, :album_id)
    )
  end
end
