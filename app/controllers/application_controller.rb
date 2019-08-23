class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :store_user_location!, if: :storable_location?

  private

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || user_path(resource_or_scope)
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath) unless request.fullpath != new_user_session_path
  end
end
