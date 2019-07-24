class ArtistsController < ApplicationController
  include Search

  before_action :set_artist, only: %i[show destroy]
  before_action :authenticate_user!

  def index
    @artists = Artist.artists_list(page: params[:page])
    if artist_name = params[:artist_name]
      @artists = Artist
      .search_artists_from_spotify(artist_name: artist_name)
      .artists_list(page: params[:page])
    end
  end

  def show
    if @artist.albums.empty?
      artists = search_artists(artist_name: @artist.name)
      artists.each do |artist|
        # FIXME: マジックナンバー対応
        Album.save_albums(albums: artist.albums(limit: 50))
      end
    end
    @albums = @artist.albums.albums_list(page: params[:page])
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
