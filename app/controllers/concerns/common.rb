# frozen_string_literal: true

module Common
  extend ActiveSupport::Concern

  def set_user(user_id:)
    @user = User.find(user_id)
  end

  def set_average_rating(album:)
    album.set_average_rating
  end

  def prohibit_unspecified_users_access
    redirect_to current_user if current_user != @user
  end

  def prohibit_sns_accout_users_access
    redirect_to current_user if current_user.provider.present?
  end
end
