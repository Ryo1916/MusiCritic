# frozen_string_literal: true

module Search
  extend ActiveSupport::Concern

  MAXIMUM_NUMBER_OF_RESULTS = 50

  def search_artists(artist_name:)
    searched_artists = Artist.search_artists(artist_name: artist_name)
    return searched_artists if searched_artists.any?

    artists = RSpotify::Artist.search(artist_name, limit: MAXIMUM_NUMBER_OF_RESULTS)
    Artist.save_artists(artists: artists)
    Artist.search_artists(artist_name: artist_name)
  end

  def search_albums_from_spotify(album_name:)
    RSpotify::Album.search(album_name, limit: MAXIMUM_NUMBER_OF_RESULTS)
  end

  def search_unique_album_from_spotify(spotifies_album_id:)
    RSpotify::Album.find(spotifies_album_id)
  end
end
