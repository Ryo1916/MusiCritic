class CreativesController < ApplicationController
  def index
    @most_rating_albums = Album.top_ratings(limit: Constants::ALBUMS_FOR_TOP_PAGE)
  end
end
