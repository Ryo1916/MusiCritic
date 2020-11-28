# frozen_string_literal: true

module YoutubeUrlsGeneratable
  extend ActiveSupport::Concern

  # Define private-like methods using Refinements feature.
  using privates {
    # NOTE: 残念ながらusernameの検索で公式チャンネルを特定することができないが、google検索のアルゴリズムを信じ、公式チャンネルが最も上位の検索結果に表示されるとして、first.idが公式チャンネルのidということにしている
    def get_channel_id(client:, name:)
      channels = client.list_channels(name: name)
      channels.items&.first&.id
    end

    def get_video_ids(client:, channel_id:)
      search_results = client.list_searches(channel_id: channel_id)
      selected_results = search_results.items.select { |item| item.id.kind == 'youtube#video' }
      selected_results.map { |item| item.id.video_id }
    end

    def get_official_video_ids(client:, video_ids:)
      video_lists = client.list_videos(video_ids: video_ids)
      # NOTE: channel_idが公式でない場合、ここで空になる
      licensed_video_lists = video_lists.items.select { |v| v.content_details.licensed_content? }
      licensed_video_lists.map { |i| i.id }
    end
  }

  def generate_youtube_urls(client:, artist_name:)
    channel_id = get_channel_id(client: client, name: artist_name)
    return nil if channel_id.nil?

    video_ids = get_video_ids(client: client, channel_id: channel_id)
    return nil if video_ids.blank?

    official_video_ids = get_official_video_ids(client: client, video_ids: video_ids)
    # NOTE: 表示のため最大4個まで表示するようにする
    official_video_ids.present? ? official_video_ids.map { |id| "https://www.youtube.com/embed/#{id}" }[0..3] : nil
  end
end
