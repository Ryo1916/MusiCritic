class Song < ApplicationRecord
  # Associations
  belongs_to :artist, optional: true
  belongs_to :album, optional: true

  # Validations
  validates_presence_of :song_name, :track_num, :artist_id, :album_id
end
