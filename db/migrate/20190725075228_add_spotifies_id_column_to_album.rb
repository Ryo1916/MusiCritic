class AddSpotifiesIdColumnToAlbum < ActiveRecord::Migration[5.1]
  def change
    add_column :albums, :spotify_id, :string, null: false
  end
end
