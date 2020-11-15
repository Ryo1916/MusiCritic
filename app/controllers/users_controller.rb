# frozen_string_literal: true

class UsersController < ApplicationController
  include UserAccessable
  include ApiClientGeneratable
  include UsersHelper

  before_action :authenticate_user!, except: %i[show] # NOTE: 各ユーザの詳細ページは誰でも見れるように
  before_action :generate_spotify_client, only: %i[show]

  def show
    request_params = UserIdRequestParams.new(params)
    request_params.validate!
    service = ShowUserService.new(request_params: request_params, client: @spotify_client, page: params[:page])
    service.run!
    set_instance_variables(service.result)
    render :show
  end

  def edit
    request_params = UserIdRequestParams.new(params)
    request_params.validate!
    @user = User.find(request_params.id)
    prohibit_unspecified_users_access
    render :edit
  end

  def update
    @user = User.find(current_user.id)
    prohibit_unspecified_users_access # NOTE: editと異なりすぐに処理を停止できるためパラメータ検証より先にアクセスコントロールしている
    request_params = UpdateUserRequestParams.new(params)
    request_params.validate!
    @user.update!(request_params.attributes)
    redirect_to @user, notice: 'Your profile was successfully updated.'
  end
end
