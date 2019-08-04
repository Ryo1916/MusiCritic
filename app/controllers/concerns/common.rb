# frozen_string_literal: true

module Common
  extend ActiveSupport::Concern
  include SpotifyAPI::V2::Client

  def set_user(user_id:)
    @user = User.find(user_id)
  end

  def set_average_rating(album:)
    album.set_average_rating
  end

  def prohibit_unspecified_users_access
    redirect_to current_user if current_user != @user
  end

  def prohibit_sns_accout_users_access
    redirect_to current_user if current_user.provider.present?
  end

  def set_instances_for_albums_show_page
    @reviews = @album.reviews.reviews_list(page: params[:page])
    @artists = unique_album(spotifies_album_id: @album.spotify_id).artists
    @top_reviewed_albums = Album.most_reviewed_albums(limit: Constants::ALBUMS_FOR_ALBUMS_SHOW_PAGE)
  end
end
