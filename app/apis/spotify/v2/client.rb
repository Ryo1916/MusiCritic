# frozen_string_literal: true

module Spotify
  module V2
    class Client
      include Singleton

      class ApiSecretError < StandardError; end

      def initialize
        validate_api_key!
      end

      def get_new_releases(limit:)
        new_releases = RSpotify::Album.new_releases(limit: limit)
        fetch_or_cache(key: 'new_releases_cache', value: new_releases)
      end

      def get_artist(spotifies_artist_id:)
        artist = RSpotify::Artist.find(spotifies_artist_id)
        fetch_or_cache(key: spotifies_artist_id, value: artist)
      end

      def get_album(spotifies_album_id:)
        album = RSpotify::Album.find(spotifies_album_id)
        fetch_or_cache(key: spotifies_album_id, value: album)
      end

      def search_artists(artist_name:)
        return if artist_name.blank?

        RSpotify::Artist.search(
          artist_name,
          limit: Constants::SPOTIFY_MAX_LIMIT
        )
      end

      def search_albums(album_name:)
        return if album_name.blank?

        RSpotify::Album.search(
          album_name,
          limit: Constants::SPOTIFY_MAX_LIMIT
        )
      end

      private

      def validate_api_key!
        spotify_api_key = Rails.application.credentials[Rails.env.to_sym][:spotify_api_key]
        spotify_api_secret = Rails.application.credentials[Rails.env.to_sym][:spotify_api_secret]
        # TODO: raiseした時にエラー通知する仕組み
        raise ApiSecretError if spotify_api_key.nil? || spotify_api_secret.nil?

        begin
          RSpotify.authenticate(spotify_api_key, spotify_api_secret)
        rescue RestClient::BadRequest => e
          Rails.logger.error "SpotifyAuthError: #{e.backtrace}"
        end
      end

      def fetch_or_cache(key:, value:)
        Rails.cache.fetch(key, expires_in: 24.hours) { value }
      end
    end
  end
end
