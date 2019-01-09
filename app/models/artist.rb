class Artist < ApplicationRecord
  mount_uploader :artist_image, ImageUploader

  # Associations
  has_many :albums, dependent: :destroy
  has_many :songs, dependent: :destroy

  # Validation
  validates :artist, presence: true, uniqueness: true
end
