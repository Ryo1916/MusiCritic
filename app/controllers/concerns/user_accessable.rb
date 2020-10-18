# frozen_string_literal: true

module UserAccessable
  extend ActiveSupport::Concern

  # TODO: 不要になったら削除, registrations_controllerでset_userをつかっているので注意
  def set_user(user_id:)
    @user = User.find(user_id)
  end

  def prohibit_unspecified_users_access
    redirect_to current_user if current_user != @user
  end

  def prohibit_sns_accout_users_access
    redirect_to current_user if current_user.provider.present?
  end
end
