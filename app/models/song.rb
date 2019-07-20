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
    def save_tracks(unique_album:, album_id:)
      unique_album.tracks.each do |track|
        Song.create!(
          name: track.name,
          track_number: track.track_number,
          album_id: album_id
        )
      end
    end
  end
end
