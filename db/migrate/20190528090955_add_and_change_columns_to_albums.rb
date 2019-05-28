class AddAndChangeColumnsToAlbums < ActiveRecord::Migration[5.1]
  def change
    add_column :albums, :release_date, :string, after: :album_name
    add_column :albums, :external_urls, :string, after: :release_date
    remove_column :albums, :release, :date
    remove_column :albums, :genre, :string
    remove_column :albums, :description, :text
    rename_column :albums, :album_name, :name
    rename_column :albums, :album_image, :image
  end
end
