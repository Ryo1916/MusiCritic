module ArtistsHelper
  def set_instance_variables(result)
    @artist = result.artist
    @albums = result.albums
    @singles = result.singles
    @compilations = result.compilations
    @related_artists = result.related_artists
    @youtube_urls = result.youtube_urls
  end
end
