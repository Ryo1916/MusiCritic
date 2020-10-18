module UsersHelper
  def current_user?(user:)
    current_user == user
  end

  def set_instance_variables(service_result)
    @user = service_result.user
    @reviews = service_result.reviews
    @user_reviewed_albums = service_result.user_reviewed_albums
    @top_rating_albums = service_result.top_rating_albums
    @new_releases = service_result.new_releases
  end
end
