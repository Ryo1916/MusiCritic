class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: %i[index]

  def index
    @users = User.all
  end

  def show; end

  def edit; end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
