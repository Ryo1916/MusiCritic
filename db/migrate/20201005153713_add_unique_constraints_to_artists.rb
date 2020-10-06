class AddUniqueConstraintsToArtists < ActiveRecord::Migration[5.2]
  def change
    add_index :artists, :spotify_id, unique: true
  end
end
