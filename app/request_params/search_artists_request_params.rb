# frozen_string_literal: true

class SearchArtistsRequestParams < BaseRequestParams
  attribute :artist_name, :string

  validates :artist_name, presence: true

  def initialize(params)
    super(params.permit(:artist_name))
  end
end
