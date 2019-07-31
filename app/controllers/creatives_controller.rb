class CreativesController < ApplicationController
  def index
    @most_reviewed_albums = Album.most_reviewed_albums(limit: Constants::ALBUMS_FOR_TOP_PAGE)
  end
end
