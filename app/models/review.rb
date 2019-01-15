class Review < ApplicationRecord
  # Association
  belongs_to :user

  # Validations
  validates_presence_of :title, :text, :user_id, :album_id
  validates :rating, presence: true,
                     numericality: { greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 5 }
end
