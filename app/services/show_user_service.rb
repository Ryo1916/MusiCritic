# frozen_string_literal: true

class ShowUserService < BaseService
  attr_reader :result

  def initialize(request_params:, client:, page:)
    @request_params = request_params
    @client = client
    @page = page
  end

  def run!
    user_id = @request_params.id

    user = User.find(user_id)
    reviews = Review.eager_load(:user, :album)
                    .where(user_id: user_id)
                    .reviews_list(page: @page) # TODO: reviews_listが機能してるかseedでデータ大量投入して検証
    user_reviewed_albums = reviews.map { |review| review.album }.uniq
    top_rating_albums = Album.preload(:artists)
                             .top_ratings(limit: Constants::ALBUMS_FOR_INSTRUCTIONS)
    new_releases = @client.get_new_releases(limit: Constants::ALBUMS_FOR_INSTRUCTIONS)

    @result = OpenStruct.new(
      user: user,
      reviews: reviews,
      user_reviewed_albums: user_reviewed_albums,
      top_rating_albums: top_rating_albums,
      new_releases: new_releases
    )
  end
end
