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
#  spotify_id    :string(255)      not null
#

class Artist < ApplicationRecord
  # Associations
  has_many :artits_albums, dependent: :destroy
  has_many :albums, through: :artits_albums

  # Validation
  validates_presence_of :name, :image, :external_urls

  class << self
    def artists_list(page:)
      order(name: 'ASC').page(page).per(Constants::ARTISTS_FOR_ARTISTS_INDEX_PAGE)
    end

    def search_artists(artist_name:)
      where('name LIKE ?', "%#{artist_name}%")
    end

    def save_artists(artists:, artist_name:)
      artists.each do |artist|
        Artist.create!(
          name: artist.name,
          image: artist.images.empty? ? Constants::DEFAULT_IMG_URL : artist.images[0]["url"],
          external_urls: artist.external_urls["spotify"]
        )
      end
    end
  end
end
