# == Schema Information
#
# Table name: albums
#
#  id             :bigint(8)        not null, primary key
#  name           :string(255)
#  release_date   :string(255)
#  external_urls  :string(255)
#  image          :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  reviews_count  :integer          default(0), not null
#  average_rating :float(24)        default(0.0), not null
#  spotify_id     :string(255)      not null
#

class Album < ApplicationRecord
  # Associations
  has_many :artists_albums, dependent: :destroy
  has_many :artists, through: :artists_albums
  has_many :songs, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # Validations
  validates_presence_of :name, :release_date, :external_urls, :image
  validates :spotify_id, uniqueness: true

  # TODO: 未使用メソッド削除
  class << self
    def pagination(page:)
      page(page).per(Constants::ARTISTS_FOR_ARTISTS_INDEX_PAGE)
    end

    def top_ratings(limit:)
      order(average_rating: :desc).limit(limit)
    end
  end

  def update_average_rating
    update_attributes(average_rating: (self.reviews.blank? ? 0.0 : self.reviews.average(:rating).round(2)))
  end
end
