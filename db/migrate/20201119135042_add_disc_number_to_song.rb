class AddDiscNumberToSong < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :disc_number, :integer
  end
end
