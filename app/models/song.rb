# == Schema Information
#
# Table name: songs
#
#  id           :bigint(8)        not null, primary key
#  name         :string(255)
#  track_number :integer
#  album_id     :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  preview_url  :string(255)
#

class Song < ApplicationRecord
  # Associations
  belongs_to :album

  # Validations
  validates_presence_of :name, :track_number, :album_id

  scope :order_by_track_number, -> { order(track_number: :asc) }
end
