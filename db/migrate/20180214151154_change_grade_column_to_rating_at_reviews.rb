class ChangeGradeColumnToRatingAtReviews < ActiveRecord::Migration[5.1]
  def change
    rename_column :reviews, :grade, :rating
  end
end
