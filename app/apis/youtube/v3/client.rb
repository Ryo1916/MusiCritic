# frozen_string_literal: true

require 'google/apis/youtube_v3'

module Youtube
  module V3
    class Client
      include Singleton

      class ApiSecretError < StandardError; end

      def initialize
        validate_api_key!
        @service = Google::Apis::YoutubeV3::YouTubeService.new
        @service.key = @google_api_key
      end

      # NOTE: https://developers.google.com/youtube/v3/docs/channels/list
      def list_channels(name:)
        part = %i[id].freeze
        username = name.delete(' ') # NOTE: 空白文字を除いた文字列でアーティスト名が検索できるため削除

        Rails.cache.fetch("#{username}/list_channels", expires_in: 12.hours) do
          @service.list_channels(part, for_username: username)
        end
      end

      # NOTE: https://developers.google.com/youtube/v3/docs/search/list
      def list_searches(channel_id:)
        part = %i[snippet].freeze

        Rails.cache.fetch("#{channel_id}/list_searches", expires_in: 12.hours) do
          @service.list_searches(part, channel_id: channel_id, type: 'video', max_results: 12)
        end
      end

      # NOTE: https://developers.google.com/youtube/v3/docs/videos/list
      def list_videos(video_ids:)
        part = %i[snippet content_details].freeze
        joined_id = video_ids.join # NOTE: cacheのためユニークになる文字列を生成

        Rails.cache.fetch("#{joined_id}/list_videos", expires_in: 12.hours) do
          @service.list_videos(part, id: video_ids)
        end
      end

      private

      def validate_api_key!
        @google_api_key = Rails.application.credentials[Rails.env.to_sym][:google_api_key]
        # TODO: raiseした時にエラー通知する仕組み
        raise ApiSecretError if @google_api_key.nil?
      end
    end
  end
end
