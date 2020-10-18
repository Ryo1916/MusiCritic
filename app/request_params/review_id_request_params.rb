# frozen_string_literal: true

class ReviewIdRequestParams < BaseRequestParams
  attribute :id, :integer

  validates :id, presence: true, numericality: { greater_than: 0, only_integer: true }

  def initialize(params)
    super(params.permit(:id))
  end
end
