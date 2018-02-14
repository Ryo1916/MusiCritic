class RenameNameColumnInSongs < ActiveRecord::Migration[5.1]
  def change
    rename_column :songs, :name, :song_name
  end
end
