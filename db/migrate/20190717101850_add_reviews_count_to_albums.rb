class AddReviewsCountToAlbums < ActiveRecord::Migration[5.1]
  def self.up
    add_column :albums, :reviews_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :albums, :reviews_count
  end
end
