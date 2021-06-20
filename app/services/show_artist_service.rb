# frozen_string_literal: true

class ShowArtistService < BaseService
  include YoutubeUrlsGeneratable

  attr_reader :result

  def initialize(artist_id:, spotify_client:, youtube_client:, wikipedia_client:, current_user:)
    @artist_id = artist_id
    @spotify_client = spotify_client
    @youtube_client = youtube_client
    @wikipedia_client = wikipedia_client
    @current_user = current_user
  end

  def run!
    artist = @spotify_client.get_artists(spotifies_artist_ids: @artist_id)
    related_artists = artist.related_artists
    albums = artist.albums(
      limit: Constants::SPOTIFY_MAX_LIMIT,
      offset: 0,
      album_type: 'album'
    )
    singles = artist.albums(
      limit: Constants::SPOTIFY_MAX_LIMIT,
      offset: 0,
      album_type: 'single'
    )
    compilations = artist.albums(
      limit: Constants::SPOTIFY_MAX_LIMIT,
      offset: 0,
      album_type: 'compilation'
    )

    # NOTE: youtubeAPIの上限を超えないようにするため、アカウント作成されていないと表示されないように
    youtube_urls = (@current_user.nil? ? nil : generate_youtube_urls(client: @youtube_client, artist_name: artist.name))
    # NOTE: wikipediaに対してspotifyから取得してきた正規化された名前で記事を取得
    article = @wikipedia_client.get_artist_article(name: artist.name)
    wiki_url = @wikipedia_client.get_artist_wiki_url(name: artist.name)

    @result = {
      artist: artist,
      albums: albums,
      singles: singles,
      compilations: compilations,
      related_artists: related_artists,
      youtube_urls: youtube_urls,
      article: article,
      wiki_url: wiki_url
    }
  end
end
