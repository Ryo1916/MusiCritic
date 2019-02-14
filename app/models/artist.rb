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
  mount_uploader :artist_image, ImageUploader

  # Associations
  has_many :albums, dependent: :destroy
  has_many :songs, dependent: :destroy

  # Validation
  validates_presence_of :artist, uniquness: true
end
