class AddAndChangeColumnsToArtists < ActiveRecord::Migration[5.1]
  def change
    add_column :artists, :external_urls, :string
    rename_column :artists, :artist, :name
    rename_column :artists, :artist_image, :image
  end
end
