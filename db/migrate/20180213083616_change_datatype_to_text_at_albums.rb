class ChangeDatatypeToTextAtAlbums < ActiveRecord::Migration[5.1]
  def change
    change_column :albums, :description, :text
  end
end
