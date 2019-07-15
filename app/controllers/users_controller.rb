class UsersController < ApplicationController
  include Common

  before_action :authenticate_user!
  before_action except: %i[index] do
    set_user(user_id: params[:id])
  end
  before_action :prohibit_unspecified_users_access, only: %i[edit update]

  def show
    @reviews = @user.reviews.page(params[:page]).per(1)
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
      flash[:notice] = 'Your profile was successfully updated.'
    else
      render :edit
      flash[:alert] = 'Update failed.'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :avatar)
    end
end
