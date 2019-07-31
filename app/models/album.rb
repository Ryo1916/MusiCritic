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
#  reviews_count :integer          default(0), not null
#  spotify_id    :string(255)      not null
#

class Album < ApplicationRecord
  # Associations
  has_many :artists_albums, dependent: :destroy
  has_many :artists, through: :artists_albums
  has_many :songs, dependent: :destroy
  has_many :reviews, dependent: :destroy


  # Validations
  validates_presence_of :name, :release_date, :external_urls, :image, :spotify_id

  class << self
    def albums_list(page:)
      order(name: 'ASC').page(page).per(Constants::ALBUMS_FOR_ALBUMS_INDEX_PAGE)
    end

    def most_reviewed_albums
      order(reviews_count: :desc).limit(Constants::ALBUMS_FOR_TOP_PAGE)
    end

    def search_albums(album_name:)
      where('name LIKE ?', "%#{album_name}%")
    end
  end

  def specified_user_reviews(specified_user:)
    self.reviews.select { |review| review.user == specified_user }
  end
end
