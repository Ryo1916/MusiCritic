module ArtistsHelper
  def set_instance_variables(result)
    @artist = result.artist
    @albums = result.albums
    @singles = result.single
    @compilations = result.compilations
    @related_artists = result.related_artists
  end
end
