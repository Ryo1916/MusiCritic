class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :omniauthable, :confirmable, :lockable

  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, uniqueness: true, on: :create
  validates :name, presence: true, uniqueness: true, on: :update
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

end
