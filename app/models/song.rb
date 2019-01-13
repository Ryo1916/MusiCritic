class Song < ApplicationRecord
  # Associations
  belongs_to :artist, optional: true
  belongs_to :album, optional: true

  # Validations
  validates_presence_of :song_name
  validates_presence_of :track_num
  validates_presence_of :artist_id
  validates_presence_of :album_id
end
