class Artist < ApplicationRecord
  mount_uploader :artist_image, ImageUploader

  has_many :albums, dependent: :destroy
  has_many :songs, dependent: :destroy
end
