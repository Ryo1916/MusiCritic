module SpotifyAPI
  module V2
    class Client
      class << self
        def new_releases(limit:)
          RSpotify::Album.new_releases(limit: limit)
        end

        def artists(artist_name:)
          RSpotify::Artist.search(artist_name, limit: Constants::MAXIMUM_RESULT_LIMITATION_OF_SPOTIFY_API)
        end

        def albums(album_name:)
          RSpotify::Album.search(album_name, limit: Constants::MAXIMUM_RESULT_LIMITATION_OF_SPOTIFY_API)
        end

        def unique_artist(spotifies_artist_id:)
          RSpotify::Artist.find(spotifies_artist_id)
        end

        def unique_album(spotifies_album_id:)
          RSpotify::Album.find(spotifies_album_id)
        end
      end
    end
  end
end
