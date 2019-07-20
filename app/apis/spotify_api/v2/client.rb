module SpotifyAPI
  module V2
    class Client
      MAXIMUM_NUMBER_OF_RESULTS = 50
      def search_artists(artist_name:)
        # FIXME: 空文字で検索した場合のエラーハンドリング
        RSpotify::Artist.search(artist_name, limit: MAXIMUM_NUMBER_OF_RESULTS)
      end

      def search_albums(album_name:)
        RSpotify::Album.search(album_name, limit: MAXIMUM_NUMBER_OF_RESULTS)
      end

      def search_unique_album(spotifies_album_id:)
        RSpotify::Album.find(spotifies_album_id)
      end
    end
  end
end
