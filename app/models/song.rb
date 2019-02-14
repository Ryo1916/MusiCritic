# == Schema Information
#
# Table name: songs
#
#  id         :bigint(8)        not null, primary key
#  song_name  :string(255)
#  track_num  :integer
#  artist_id  :bigint(8)
#  album_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Song < ApplicationRecord
  # Associations
  belongs_to :artist, optional: true
  belongs_to :album, optional: true

  # Validations
  validates_presence_of :song_name, :track_num, :artist_id, :album_id
end
