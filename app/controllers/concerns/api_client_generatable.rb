# frozen_string_literal: true

module ApiClientGeneratable
  extend ActiveSupport::Concern

  def generate_spotify_client
    @spotify_client = Spotify::V2::Client.instance
  end
end
