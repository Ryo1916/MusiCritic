class RenameImageColumnNameInAlbums < ActiveRecord::Migration[5.1]
  def change
    rename_column :albums, :image, :album_image
  end
end
