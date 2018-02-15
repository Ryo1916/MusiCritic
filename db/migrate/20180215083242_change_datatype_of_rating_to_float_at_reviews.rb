class ChangeDatatypeOfRatingToFloatAtReviews < ActiveRecord::Migration[5.1]
  def change
    change_column :reviews, :rating, :float
  end
end
