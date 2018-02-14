class Album < ApplicationRecord
  mount_uploader :album_image, ImageUploader

  has_many :songs, dependent: :destroy
  accepts_nested_attributes_for :songs, allow_destroy: true
  belongs_to :artist, optional: true
end
