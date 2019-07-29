class CreateArtistsAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :artists_albums do |t|
      t.integer :artist_id
      t.integer :album_id

      t.timestamps
    end
    add_index :artists_albums, :artist_id
    add_index :artists_albums, :album_id
    add_index :artists_albums, [:artist_id, :album_id], unique: true
  end
end
