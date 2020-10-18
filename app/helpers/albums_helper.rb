module AlbumsHelper
  def set_instance_variables(result)
    @album = result.album
    @top_rating_albums = result.top_rating_albums
    @artists = result.artists
    @songs = result.songs
    @reviews = result.reviews
    @review = Review.new
  end
end
