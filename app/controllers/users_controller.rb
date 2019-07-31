class UsersController < ApplicationController
  include Common
  include SpotifyAPI::V2::Client

  before_action :authenticate_user!
  before_action except: %i[index] do
    set_user(user_id: params[:id])
  end
  before_action :prohibit_unspecified_users_access, only: %i[edit update]

  def show
    @reviews = @user.reviews.reviews_list(page: params[:page])
    @new_released_albums = new_releases(limit: Constants::NEW_RELEASE_ALBUMS_FOR_INSTRUCTIONS)
    @most_reviewed_albums = Album.most_reviewed_albums(limit: Constants::ALBUMS_FOR_INSTRUCTIONS)
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
