# frozen_string_literal: true

class ArtistsController < ApplicationController
  include ApiClientGeneratable
  include ArtistsHelper

  before_action :generate_spotify_client, only: %i[index show search]
  before_action :generate_youtube_client, only: %i[show]
  before_action :generate_wikipedia_client, only: %i[show]

  def index
    new_releases = @spotify_client.get_new_releases(limit: Constants::NEW_RELEASE_ALBUMS)
    new_release_artists = new_releases.map { |release| release.artists }.flatten # feat.などで1つのアルバムに複数アーティストが存在することがあるので、flattenして二重配列をフラットにする
    artist_ids = new_release_artists.map { |artist| artist.id }
    artists = @spotify_client.get_artists(spotifies_artist_ids: artist_ids)
    top_rating_artists = Artist.get_top_rating_artists

    result = {
      new_release_artists: artists,
      top_rating_artists: top_rating_artists
    }

    render json: result
  end

  def show
    request_params = SpotifyIdRequestParams.new(params)
    request_params.validate!

    service = ShowArtistService.new(
      artist_id: request_params.id,
      spotify_client: @spotify_client,
      youtube_client: @youtube_client,
      wikipedia_client: @wikipedia_client,
      current_user: current_user
    )
    service.run!

    render json: service.result
  end

  def search
    request_params = SearchArtistsRequestParams.new(params)
    request_params.validate!
    artists = @spotify_client.search_artists(artist_name: request_params.artist_name)
    top_rating_artists = Artist.get_top_rating_artists

    result = {
      artists: artists,
      top_rating_artists: top_rating_artists
    }
    render json: result
  end
end
