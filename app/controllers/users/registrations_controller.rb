# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include UserAccessable

  invisible_captcha only: %i[create update], honeypot: :subtitle

  before_action :configure_sign_up_params, only: %i[create]
  before_action :configure_account_update_params, only: %i[update]
  before_action only: %i[edit] do
    set_user(user_id: params[:format])
  end
  before_action :prohibit_unspecified_users_access, only: %i[edit update]
  before_action :prohibit_sns_accout_users_access, only: %i[edit update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    added_attrs = %i[
      name
      avatar
      avatar_cache
      remote_avatar
    ]
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    new_user_session_path
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

  # The path used after update an account
  def after_update_path_for(resource)
    user_path(resource)
  end
end
