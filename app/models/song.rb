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
#

class Song < ApplicationRecord
  # Associations
  belongs_to :artist
  belongs_to :album

  # Validations
  validates_presence_of :name, :track_number, :artist_id, :album_id
end
