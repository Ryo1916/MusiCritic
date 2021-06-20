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
  has_many :artists_albums, dependent: :destroy
  has_many :albums, through: :artists_albums

  # Validation
  validates_presence_of :name, :image, :external_urls
  validates :spotify_id, uniqueness: true

  # TODO: 未使用メソッド削除
  class << self
    def pagination(page:)
      page(page).per(Constants::ARTISTS_FOR_ARTISTS_INDEX_PAGE)
    end

    def artists_list(page:)
      order(name: 'ASC').pagination(page: page)
    end

    def search_artists(artist_name:, page:)
      where('name LIKE ?', "%#{artist_name}%").artists_list(page: page)
    end

    def get_top_rating_artists
      self.joins(:albums)
        .order(average_rating: :desc)
        .uniq
        .take(Constants::TOP_RATING_ALBUMS)
    end
  end
end
