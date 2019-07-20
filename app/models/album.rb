# == Schema Information
#
# Table name: albums
#
#  id            :bigint(8)        not null, primary key
#  name          :string(255)
#  release_date  :string(255)
#  external_urls :string(255)
#  image         :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  artist_id     :bigint(8)
#

class Album < ApplicationRecord
  # Associations
  belongs_to :artist
  has_many :songs, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # Validations
  validates_presence_of :name, :release_date, :external_urls, :image, :artist_id

  class << self
    def albums_list(page:)
      order(name: 'ASC').page(page).per(Constants::ALBUMS_FOR_ALBUMS_INDEX_PAGE)
    end

    def most_reviewed_albums
      order(reviews_count: :desc).limit(Constants::ALBUMS_FOR_TOP_PAGE)
    end

    def search_album(album_name:, page:)
      where('name LIKE ?', "%#{album_name}%").albums_list(page: page)
    end

    def search_album_from_api(album_name:)
      client = SpotifyAPI::V2::Client.new
      client.search_album(album_name: album_name)
    end

    def search_unique_album_from_api(spotifies_album_id:)
      client = SpotifyAPI::V2::Client.new
      client.search_unique_album(spotifies_album_id: spotifies_album_id)
    end

    # FIXME: albumオブジェクトを保存するので、クラスメソッドなのはおかしいかもしれない
    #        →オブジェクト生成前のデータ保存なのでクラスメソッドでもおかしくないかも
    def save_album(albums:)
      albums.each do |album|
        # find artist to save album with artist_id
        # FIXME: Artistクラスを知りすぎているかも、しかしどうやって修正したらいいか現状わからないので保留
        if artist = Artist.find_by(name: album.artists.first.name)
          artist_id = artist.id
        else
          # Set Unknown Artist id
          artist_id = Artist.first.id
        end

        # save album data
        saved_album = Album.create!(
          name: album.name,
          release_date: album.release_date,
          external_urls: album.external_urls["spotify"],
          image: album.images.empty? ? Constants::DEFAULT_IMG_URL : album.images.first["url"],
          artist_id: artist_id
        )

        # save tracks using spotifies album id
        # FIXME: Songクラスを知りすぎているかも、しかしどうやって修正したらいいか現状わからないので保留
        unique_album = self.search_unique_album_from_api(spotifies_album_id: album.id)  # album.id is spotify's album id, not DB's one.
        Song.save_tracks(unique_album: unique_album, album_id: saved_album.id)
      end
    end
  end
end
