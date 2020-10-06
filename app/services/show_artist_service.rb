# frozen_string_literal: true

class ShowArtistService < BaseService
  attr_reader :result

  def initialize(artist_id:, client:)
    @artist_id = artist_id
    @client = client
  end

  def run!
    artist = @client.get_artist(spotifies_artist_id: @artist_id)
    albums = artist.albums(
      limit: Constants::SPOTIFY_MAX_LIMIT,
      offset: 0,
      album_type: 'album'
    )
    singles = artist.albums(
      limit: Constants::SPOTIFY_MAX_LIMIT,
      offset: 0,
      album_type: 'single'
    )
    compilations = artist.albums(
      limit: Constants::SPOTIFY_MAX_LIMIT,
      offset: 0,
      album_type: 'compilation'
    )
    related_artists = artist.related_artists

    @result = OpenStruct.new(
      artist: artist,
      albums: albums,
      singles: singles,
      compilations: compilations,
      related_artists: related_artists
    )
  end
end
