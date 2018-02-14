class AddTrackNumToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :track_num, :integer, :after => :song_name
  end
end
