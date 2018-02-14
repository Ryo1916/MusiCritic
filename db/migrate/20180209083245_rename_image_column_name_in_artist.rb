class RenameImageColumnNameInArtist < ActiveRecord::Migration[5.1]
  def change
    rename_column :artists, :image, :artist_image
  end
end
