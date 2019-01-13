class Album < ApplicationRecord
  mount_uploader :album_image, ImageUploader

  # Associations
  belongs_to :artist, optional: true
  has_many :songs, dependent: :destroy
  accepts_nested_attributes_for :songs, allow_destroy: true
  has_many :reviews, dependent: :destroy

  # Validations
  validates_presence_of :album_name, uniqueness: true
  validates :release, presence: true, uniqueness: true
  validates :genre, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true
  validates :album_image, presence: true
  validates :artist_id, presence: true, uniqueness: true
end
