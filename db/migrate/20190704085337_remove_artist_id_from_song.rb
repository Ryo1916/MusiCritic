class RemoveArtistIdFromSong < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :songs, column: :artist_id
    remove_reference :songs, :artist, index: true
  end
end
