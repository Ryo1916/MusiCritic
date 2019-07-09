module SpotifyAPI
  module V2
    class Client
      def search_artist(artist_name:)
        # FIXME: 空文字で検索した場合のエラーハンドリング
        RSpotify::Artist.search(artist_name)
      end

      def search_album(album_name:)
        RSpotify::Album.search(album_name)
      end

      def search_unique_album(spotifies_album_id:)
        RSpotify::Album.find(spotifies_album_id)
      end
    end
  end
end
