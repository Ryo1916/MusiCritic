class AddAverageRatingToAlbum < ActiveRecord::Migration[5.1]
  def change
    add_column :albums, :average_rating, :float, after: :reviews_count, default: 0, null: false
  end
end
