class RemoveArtistIdFromAlbums < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :albums, column: :artist_id
    remove_reference :albums, :artist, index: true
  end
end
