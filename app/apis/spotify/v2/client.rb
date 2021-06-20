# frozen_string_literal: true

module Spotify
  module V2
    class Client
      include Singleton

      class ApiSecretError < StandardError; end

      def initialize
        validate_api_key!
      end

      # TODO: cacheをclient外でやるように
      def get_new_releases(limit:)
        Rails.cache.fetch('new_releases', expires_in: 12.hours) do
          RSpotify::Album.new_releases(limit: limit)
        end
      end

      # String or Array
      def get_artists(spotifies_artist_ids:)
        Rails.cache.fetch("#{spotifies_artist_ids}/artist", expires_in: 12.hours) do
          RSpotify::Artist.find(spotifies_artist_ids)
        end
      end

      def get_album(spotifies_album_id:)
        Rails.cache.fetch("#{spotifies_album_id}/album", expires_in: 12.hours) do
          RSpotify::Album.find(spotifies_album_id)
        end
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
          # TODO: 認証失敗した時のエラー通知
          Rails.logger.error "SpotifyAuthError: #{e.backtrace}"
        end
      end
    end
  end
end
