class AddUniqueConstraintsToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_index :albums, :spotify_id, unique: true
  end
end
