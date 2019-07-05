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
    def search_album(album_name:)
      Album.where('name LIKE ?', "%#{album_name}%").order(name: 'ASC')
    end

    def search_album_from_api(album_name:)
      client = SpotifyAPI::V2::Client.new
      client.search_album(album_name: album_name)
    end

    def search_unique_album_from_api(spotifies_album_id:)
      client = SpotifyAPI::V2::Client.new
      client.search_unique_album(spotifies_album_id: spotifies_album_id)
    end

    def save_album(albums:, album_name:)
      albums.each do |album|
        # save album data with artist_id
        artist_id = Artist.find_by(name: album.artists.first.name).id

        # save the albums data
        Album.create!(
          name: album.name,
          release_date: album.release_date,
          external_urls: album.external_urls["spotify"],
          image: album.images.empty? ? Constants::DEFAULT_IMG_URL : album.images.first["url"],
          artist_id: artist_id
        )

        # save tracks using spotifies album id
        unique_album = self.search_unique_album_from_api(spotifies_album_id: album.id)  # album.id is spotify's album id, not DB's one.
        # FIXME: 同名アルバムがあると、最初にfindされたartist_id, album_idを使ってsaveしてしまう
        album_id = Album.find_by(name: unique_album.name).id
        Song.save_albums_tracks_data(unique_album: unique_album, album_id: album_id)
      end
      self.search_album(album_name: album_name)
    end
  end
end
