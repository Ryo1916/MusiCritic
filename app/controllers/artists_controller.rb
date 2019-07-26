class ArtistsController < ApplicationController
  include SpotifyAPI::V2::Client

  before_action :authenticate_user!
  before_action :set_artist, only: %i[destroy]

  def index
    @artists = new_releases.inject([]) do |result, new_release|
      result + new_release.artists
    end

    if artist_name = params[:artist_name]
      @artists = search_artists_from_spotify(artist_name: artist_name)
    end
  end

  def show
    # FIXME: 検索せずに@artistsを利用して表示できないか？
    @artist = search_unique_artist_from_spotify(spotifies_artist_id: params[:id])
    # FIXME: マジックナンバー
    @albums = @artist.albums(limit: 50)
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
