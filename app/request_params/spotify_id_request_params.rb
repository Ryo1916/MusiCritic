# frozen_string_literal: true

class SpotifyIdRequestParams < BaseRequestParams
  attribute :id, :string

  validates :id, presence: true

  def initialize(params)
    super(params.permit(:id))
  end
end
