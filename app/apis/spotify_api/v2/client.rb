module SpotifyAPI
  module V2
    module Client
      RESULT_LIMITATION_OF_NEW_RELEASES = 10
      MAXIMUM_NUMBER_OF_RESULTS = 50

      def new_releases
        RSpotify::Album.new_releases(limit: RESULT_LIMITATION_OF_NEW_RELEASES)
      end

      def search_artists_from_spotify(artist_name:)
        RSpotify::Artist.search(artist_name, limit: MAXIMUM_NUMBER_OF_RESULTS)
      end

      def search_albums_from_spotify(album_name:)
        RSpotify::Album.search(album_name, limit: MAXIMUM_NUMBER_OF_RESULTS)
      end

      def search_unique_artist_from_spotify(spotifies_artist_id:)
        RSpotify::Artist.find(spotifies_artist_id)
      end

      def search_unique_album_from_spotify(spotifies_album_id:)
        RSpotify::Album.find(spotifies_album_id)
      end
    end
  end
end
