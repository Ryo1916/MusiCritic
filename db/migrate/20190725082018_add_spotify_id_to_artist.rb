class AddSpotifyIdToArtist < ActiveRecord::Migration[5.1]
  def change
    add_column :artists, :spotify_id, :string, null: false
  end
end
