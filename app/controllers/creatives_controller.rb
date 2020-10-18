class CreativesController < ApplicationController
  include ApiClientGeneratable

  before_action :generate_spotify_client, only: %i[index]

  def index
    @top_rating_albums = Album.preload(:artists)
                              .top_ratings(limit: Constants::ALBUMS_FOR_TOP_PAGE)
    @new_releases = @spotify_client.get_new_releases(limit: Constants::ALBUMS_FOR_TOP_PAGE)
  end
end
