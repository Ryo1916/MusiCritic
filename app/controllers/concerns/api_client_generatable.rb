# frozen_string_literal: true

module ApiClientGeneratable
  extend ActiveSupport::Concern

  def generate_spotify_client
    @spotify_client ||= ::Spotify::V2::Client.instance
  end

  def generate_youtube_client
    @youtube_client ||= ::Youtube::V3::Client.instance
  end

  def generate_wikipedia_client
    @wikipedia_client ||= ::Wikipedia::V1::Client.instance
  end
end
