# == Schema Information
#
# Table name: artists
#
#  id           :bigint(8)        not null, primary key
#  artist       :string(255)
#  artist_image :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Artist < ApplicationRecord
  # Associations
  has_many :albums, dependent: :destroy
  has_many :songs, dependent: :destroy

  # Validation
  validates_presence_of :name, uniquness: true

  class << self
    DEFAULT_IMG_URL = 'https://s.discogs.com/images/default-artist.png'

    def search_artist(artist_name:)
      Artist.where('name LIKE ?', "%#{artist_name}%").order(name: 'ASC')
    end

    def save_data_from_api(artist_name:)
      artists = RSpotify::Artist.search(artist_name)
      if artists.any?
        artists.each do |artist|
          new_artist = Artist.new
          new_artist.name = artist.name
          if artist.images.empty?
            new_artist.image = DEFAULT_IMG_URL
          else
            new_artist.image = artist.images[0]["url"]
          end
          new_artist.external_urls = artist.external_urls["spotify"]
          new_artist.save
        end
      end
      @artists = search_artist(artist_name: artist_name)
    end
  end
end
