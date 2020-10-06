class ArtistsController < ApplicationController
  include ApiClientGeneratable
  include ArtistsHelper

  before_action :generate_spotify_client, only: %i[show search]

  def index
    @top_rating_artists = Album.eager_load(:artists)
                               .top_ratings(limit: Constants::TOP_RATING_ALBUMS)
                               .inject([]) { |result, album| result + album.artists }
                               .uniq
    respond_to { |format| format.html { render :index } }
  end

  def show
    request_params = SpotifyIdRequestParams.new(params)
    request_params.validate!
    service = ShowArtistService.new(artist_id: request_params.id, client: @spotify_client)
    service.run!
    set_instance_variables(service.result)
    respond_to { |format| format.html { render :show } }
  end

  def search
    request_params = SearchArtistsRequestParams.new(params)
    request_params.validate!

    @artists = @spotify_client.search_artists(artist_name: request_params.artist_name)
    # NOTE: 複数のアルバムがtop_ratingsにあるアーティストが重複して表示されないようにuniqしている
    @top_rating_artists = Album.eager_load(:artists)
                               .top_ratings(limit: Constants::TOP_RATING_ALBUMS)
                               .inject([]) { |result, album| result + album.artists }
                               .uniq

    respond_to do |format|
      format.html { render :index }
      flash.now[:alert] = 'Please enter artist name.' if @artists.blank?
    end
  end
end
