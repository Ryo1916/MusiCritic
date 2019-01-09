class Album < ApplicationRecord
  mount_uploader :album_image, ImageUploader

  # Associations
  belongs_to :artist, optional: true
  has_many :songs, dependent: :destroy
  accepts_nested_attributes_for :songs, allow_destroy: true
  has_many :reviews, dependent: :destroy

  # Validations
  # validates :album, presence: true
  # validates :release, presence: true
  # validates :genre, presence: true
  # validates :description, presence: true
  # validates :artist_id, presence: true
end
