class RenameNameColumnInAlbums < ActiveRecord::Migration[5.1]
  def change
    rename_column :albums, :name, :album_name
  end
end
