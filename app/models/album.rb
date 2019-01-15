class Album < ApplicationRecord
  mount_uploader :album_image, ImageUploader

  # Associations
  belongs_to :artist, optional: true
  has_many :songs, dependent: :destroy
  accepts_nested_attributes_for :songs, allow_destroy: true
  has_many :reviews, dependent: :destroy

  # Validations
  validates_presence_of :album_name, :release, :genre,
                        :description, :artist_id, uniqueness: true
  validates_presence_of :album_image
end
