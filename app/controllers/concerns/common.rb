# frozen_string_literal: true

module Common
  extend ActiveSupport::Concern

  # ここにset_userメソッドを書かないと、その下のprohibit_unspecified_users_accessメソッドで
  # いきなり@userが出てきて混乱するので、Commonモジュールにset_userメソッドを定義
  def set_user
    if params[:id]
      @user = User.find(params[:id])
    elsif params[:format]
      @user = User.find(params[:format])
    else
      @user = current_user
    end
  end

  def prohibit_unspecified_users_access
    redirect_to current_user if current_user != @user
  end

  def prohibit_sns_accout_users_access
    redirect_to current_user if current_user.provider.present?
  end
end
