# frozen_string_literal: true

class ArtistsController < ApplicationController
  include ApiClientGeneratable
  include ArtistsHelper

  before_action :generate_spotify_client, only: %i[show search]

  def index
    @top_rating_artists = Artist.joins(:albums)
                                .order(average_rating: :desc)
                                .uniq
                                .take(Constants::TOP_RATING_ALBUMS)
    render :index
  end

  def show
    request_params = SpotifyIdRequestParams.new(params)
    request_params.validate!
    service = ShowArtistService.new(artist_id: request_params.id, client: @spotify_client)
    service.run!
    set_instance_variables(service.result)
    render :show
  end

  def search
    request_params = SearchArtistsRequestParams.new(params)
    request_params.validate!
    @artists = @spotify_client.search_artists(artist_name: request_params.artist_name)
    @top_rating_artists = Artist.joins(:albums)
                                .order(average_rating: :desc)
                                .uniq
                                .take(Constants::TOP_RATING_ALBUMS)
    render :index
  end
end
