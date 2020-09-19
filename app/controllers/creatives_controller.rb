class CreativesController < ApplicationController
  def index
    @top_rating_albums = Album.eager_load(:artists).top_ratings(limit: Constants::ALBUMS_FOR_TOP_PAGE)
    @new_releases = SpotifyAPI::V2::Client.new_releases(limit: Constants::ALBUMS_FOR_TOP_PAGE)
  end
end
