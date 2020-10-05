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
        RSpotify::Album.new_releases(limit: limit)
      end

      def get_artist(spotifies_artist_id:)
        RSpotify::Artist.find(spotifies_artist_id)
      end

      def get_album(spotifies_album_id:)
        RSpotify::Album.find(spotifies_album_id)
      end

      def search_artists(artist_name:)
        return if artist_name.blank?

        RSpotify::Artist.search(
          artist_name,
          limit: Constants::MAXIMUM_RESULT_LIMITATION_OF_SPOTIFY_API
        )
      end

      def search_albums(album_name:)
        return if album_name.blank?

        RSpotify::Album.search(
          album_name,
          limit: Constants::MAXIMUM_RESULT_LIMITATION_OF_SPOTIFY_API
        )
      end

      private

      def validate_api_key!
        spotify_api_key = Rails.application.credentials[Rails.env.to_sym][:spotify_api_key]
        spotify_api_secret = Rails.application.credentials[Rails.env.to_sym][:spotify_api_secret]
        raise ApiSecretError if spotify_api_key.nil? || spotify_api_secret.nil?

        begin
          RSpotify.authenticate(spotify_api_key, spotify_api_secret)
        rescue RestClient::BadRequest => e
          Rails.logger.error "SpotifyAuthError: #{e.backtrace}"
        end
      end

      # TODO: avaliable_marketがUSのものを一律で表示しないようにする
      # def delete_duplicated_albums; end
    end
  end
end
