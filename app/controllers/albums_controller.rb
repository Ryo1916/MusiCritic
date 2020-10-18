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

    respond_to { |format| format.html { render :index } }
  end

  def show
    # TODO: params[:page]の検証
    request_params = SpotifyIdRequestParams.new(params)
    request_params.validate!
    service = ShowAlbumService.new(request_params: request_params, client: @spotify_client, page: params[:page])
    service.run!
    set_instance_variables(service.result)
    respond_to { |format| format.html { render :show } }
  end

  def search
    request_params = SearchAlbumsRequestParams.new(params)
    request_params.validate!

    @albums = @spotify_client.search_albums(album_name: request_params.album_name)
    @new_releases = @spotify_client.get_new_releases(limit: Constants::NEW_RELEASE_ALBUMS)
    @top_rating_albums = Album.preload(:artists)
                              .top_ratings(limit: Constants::TOP_RATING_ALBUMS)

    respond_to do |format|
      format.html { render :index }
      flash.now[:alert] = 'Please enter album name.' if @albums.blank?
    end
  end
end
