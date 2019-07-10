# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  name                   :string(255)      default(""), not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string(255)
#  uid                    :string(255)
#

class User < ApplicationRecord
  # image uploader
  mount_uploader :avatar, AvatarUploader

  # association
  has_many :reviews, dependent: :destroy

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :confirmable, :lockable,
         :omniauthable, omniauth_providers: %i[facebook]

  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validate :avatar_size

  # Omniauth
  class << self
    def from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first do |user|
        user.name = auth.info.name
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.remote_avatar_url = auth.info.image
      end
    end

    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"]
          user.name = data["extra"]["raw_info"]["name"] if user.name.blank?
          user.email = data["extra"]["raw_info"]["email"] if user.email.blank?
          user.password = Devise.friendly_token[0, 20]
          user.provider = data["provider"] if user.provider.blank?
          user.uid = data["uid"] if user.uid.blank?
          user.remote_avatar_url = data["info"]["image"] if user.avatar.blank?
        end
      end
    end
  end

  private

    def avatar_size
      if avatar.size > 5.megabytes
        errors.add(:avatar, "should be less than 5MB")
      end
    end
end
