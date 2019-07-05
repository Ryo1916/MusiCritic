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
  belongs_to :album

  # Validations
  validates_presence_of :name, :track_number, :album_id

  class << self
    def save_albums_tracks_data(unique_album:, album_id:)
      unique_album.tracks.each do |track|
        new_song = Song.new
        new_song.name = track.name
        new_song.track_number = track.track_number
        new_song.album_id = album_id
        new_song.save
      end
    end
  end
end
