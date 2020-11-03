# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  invisible_captcha only: %i[create], honeypot: :subtitle

  before_action :user_signed_in?, only: %i[new create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
