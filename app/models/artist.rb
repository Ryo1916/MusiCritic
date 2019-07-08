# == Schema Information
#
# Table name: artists
#
#  id            :bigint(8)        not null, primary key
#  name          :string(255)
#  image         :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  external_urls :string(255)
#

class Artist < ApplicationRecord
  # Associations
  has_many :albums, dependent: :destroy
  has_many :songs, dependent: :destroy

  # Validation
  validates :name, presence: true

  class << self
    def search_artist(artist_name:)
      Artist.where('name LIKE ?', "%#{artist_name}%").order(name: 'ASC')
    end

    def search_artist_from_api(artist_name:)
      client = SpotifyAPI::V2::Client.new
      client.search_artist(artist_name: artist_name)
    end

    def save_artist(artists:, artist_name:)
      artists.each do |artist|
        Artist.create!(
          name: artist.name,
          image: artist.images.empty? ? Constants::DEFAULT_IMG_URL : artist.images[0]["url"],
          external_urls: artist.external_urls["spotify"]
        )
      end
      self.search_artist(artist_name: artist_name)
    end
  end
end
