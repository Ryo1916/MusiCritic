# frozen_string_literal: true

class AlbumsController < ApplicationController
  include UserAccessable
  include ApiClientGeneratable
  include AlbumsHelper

  before_action :generate_spotify_client, only: %i[index show search]

  def index
    @new_releases = @spotify_client.get_new_releases(limit: Constants::NEW_RELEASE_ALBUMS)
    @top_rating_albums = Album.preload(:artists)
                              .top_ratings(limit: Constants::TOP_RATING_ALBUMS)

    result = {
      new_releases: @new_releases,
      top_rating_albums: @top_rating_albums
    }
    render json: result
  end

  def show
    request_params = SpotifyIdRequestParams.new(params)
    request_params.validate!
    service = ShowAlbumService.new(request_params: request_params, client: @spotify_client)
    service.run!
    render json: service.result.to_json
  end

  def search
    request_params = SearchAlbumsRequestParams.new(params)
    request_params.validate!
    @albums = @spotify_client.search_albums(album_name: request_params.album_name)
    @new_releases = @spotify_client.get_new_releases(limit: Constants::NEW_RELEASE_ALBUMS)
    @top_rating_albums = Album.preload(:artists)
                              .top_ratings(limit: Constants::TOP_RATING_ALBUMS)
    render :index
  end
end
