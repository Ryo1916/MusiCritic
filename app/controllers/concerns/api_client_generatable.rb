# frozen_string_literal: true

module ApiClientGeneratable
  extend ActiveSupport::Concern

  def generate_spotify_client
    # TODO: 毎回spotifyにauthenticateしたくないのでメモ化、意味があるかどうかは要確認
    @spotify_client ||= ::Spotify::V2::Client.instance
  end
end
