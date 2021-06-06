# frozen_string_literal: true

class ShowAlbumService < BaseService
  attr_reader :result

  def initialize(request_params:, client:)
    @request_params = request_params
    @client = client
  end

  def run!
    album_id = @request_params.id
    album = @client.get_album(spotifies_album_id: album_id)

    artists = album.artists
    songs = album.tracks

    # NOTE: 曲一覧は関連アルバムには不要なのでpreloadしていない
    top_rating_albums = Album.preload(:artists)
                             .where.not(spotify_id: album_id) # NOTE: 表示中のアルバムを関連アルバム一覧に表示したくないので除外している
                             .top_ratings(limit: Constants::TOP_RATING_ALBUMS)
    reviews = Review.eager_load(:user, :album)
                    .where(albums: { spotify_id: album_id })

    @result = {
      album: album,
      top_rating_albums: top_rating_albums,
      artists: artists,
      songs: songs,
      reviews: reviews
    }
  end
end
