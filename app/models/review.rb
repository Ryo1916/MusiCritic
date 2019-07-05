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
  validates :rating, presence: true,
                     numericality: { greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 5 }
end
