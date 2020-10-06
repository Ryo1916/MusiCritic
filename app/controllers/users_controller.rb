class UsersController < ApplicationController
  include UserAccessable
  include ApiClientGeneratable

  before_action :authenticate_user!, except: %i[show]
  before_action except: %i[index] do
    set_user(user_id: params[:id])
  end
  before_action :prohibit_unspecified_users_access, only: %i[edit update]
  before_action :generate_spotify_client, only: %i[show]

  def show
    @reviews = Review.where(user_id: @user.id)
                     .reviews_list(page: params[:page])
    @user_reviewed_albums = Album.eager_load(:reviews)
                                 .where(reviews: { user_id: @user.id })
                                 .uniq
    @top_rating_albums = Album.top_ratings(limit: Constants::ALBUMS_FOR_INSTRUCTIONS)
    @new_released_albums = @spotify_client.get_new_releases(limit: Constants::NEW_RELEASE_ALBUMS_FOR_INSTRUCTIONS)
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
