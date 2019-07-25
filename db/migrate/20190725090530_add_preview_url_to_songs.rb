class AddPreviewUrlToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :preview_url, :string
  end
end
