class ArtistsController < ApplicationController
  include SpotifyAPI::V2::Client

  before_action :authenticate_user!
  before_action :set_artist, only: %i[destroy]

  def index
    @top_reviewed_artists = Album
      .most_reviewed_albums(limit: Constants::ARTISTS_FOR_ARTISTS_INDEX_PAGE)
      .inject([]) { |result, album| result + album.artists }.uniq

    if artist_name = params[:artist_name]
      @artists = artists(artist_name: artist_name)
    end
  end

  def show
    @artist = unique_artist(spotifies_artist_id: params[:id])
    @albums = @artist.albums(
      limit: Constants::MAXIMUM_RESULT_LIMITATION_OF_SPOTIFY_API,
      offset: 0,
      album_type: 'album'
    )
    @singles = @artist.albums(
      limit: Constants::MAXIMUM_RESULT_LIMITATION_OF_SPOTIFY_API,
      offset: 0,
      album_type: 'single'
    )
    @compilations = @artist.albums(
      limit: Constants::MAXIMUM_RESULT_LIMITATION_OF_SPOTIFY_API,
      offset: 0,
      album_type: 'compilation'
    )
    @related_artists = @artist.related_artists[0..7]
    @top_reviewed_artists = Album
      .most_reviewed_albums(limit: Constants::ARTISTS_FOR_ARTISTS_SHOW_PAGE)
      .inject([]) { |result, album| result + album.artists }.uniq
  end

  def destroy
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_artist
    @artist = Artist.find(params[:id])
  end
end
