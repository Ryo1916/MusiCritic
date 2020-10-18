# == Schema Information
#
# Table name: reviews
#
#  id         :bigint(8)        not null, primary key
#  title      :string(255)
#  rating     :float(24)
#  text       :text(65535)
#  user_id    :bigint(8)
#  album_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Review < ApplicationRecord
  # Association
  belongs_to :user
  belongs_to :album

  # Validations
  validates_presence_of :title, :text, :user_id, :album_id
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  # Counter culture
  counter_culture :album

  # Callback
  after_commit :update_album_average_rating

  # TODO: 未使用メソッド削除
  class << self
    def reviews_list(page:)
      order('reviews.created_at desc').page(page).per(Constants::REVIEWS_FOR_ALBUMS_SHOW_PAGE)
    end
  end

  private

  # FIXME: reviewモデルがalbumのインスタンスを知っているのは変
  def update_album_average_rating
    album.update_average_rating
  end
end
