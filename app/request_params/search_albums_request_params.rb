# frozen_string_literal: true

class SearchAlbumsRequestParams < BaseRequestParams
  attribute :album_name, :string

  validates :album_name, presence: true

  def initialize(params)
    super(params.permit(:album_name))
  end
end
