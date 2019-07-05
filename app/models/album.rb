# == Schema Information
#
# Table name: albums
#
#  id            :bigint(8)        not null, primary key
#  name          :string(255)
#  release_date  :string(255)
#  external_urls :string(255)
#  image         :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  artist_id     :bigint(8)
#

class Album < ApplicationRecord
  # Associations
  belongs_to :artist
  has_many :songs, dependent: :destroy
  accepts_nested_attributes_for :songs, allow_destroy: true
  has_many :reviews, dependent: :destroy

  # Validations
  validates_presence_of :name, :release_date, :external_urls, :image, :artist_id
end
