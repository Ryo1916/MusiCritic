class ChangeAndAddColumnsToReviews < ActiveRecord::Migration[5.1]
  def change
    change_column :reviews, :text, :text
    add_reference :reviews, :album, index: true, :after => :user_id
  end
end
