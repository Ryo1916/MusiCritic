class ChangeColumnsToSongs < ActiveRecord::Migration[5.1]
  def change
    rename_column :songs, :song_name, :name
    rename_column :songs, :track_num, :track_number
  end
end
