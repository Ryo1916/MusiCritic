class Review < ApplicationRecord
  # Association
  belongs_to :user

  # Validations
  validates_presence_of :title
  validates_presence_of :rating
  validates_presence_of :text
  validates_presence_of :user_id
  validates_presence_of :album_id
end
