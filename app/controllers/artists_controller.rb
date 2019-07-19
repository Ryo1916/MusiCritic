class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[show destroy]
  before_action :authenticate_user!

  def show
    @albums = @artist.albums.albums_list(page: params[:page])
  end

  def index
    @artists = Artist.artists_list(page: params[:page])
    if params[:artist_name]
      # FIXME: search_artistが2回書いてあるのは冗長かも？
      # FIXME: DBに保存済みのアーティストはspotifyに検索しないロジックになっているため、
      #        新しく同名アーティストがspotifyに登録された場合そのアーティストをDBに保存できない
      #        「spotifyとDB検索→比較→差分を保存」にする
      @artists = Artist.search_artist(artist_name: params[:artist_name]).artists_list(page: params[:page])
      if @artists.empty?
        artists = Artist.search_artist_from_api(artist_name: params[:artist_name])
        Artist.save_artist(artists: artists, artist_name: params[:artist_name])
        @artists = Artist.search_artist(artist_name: params[:artist_name]).artists_list(page: params[:page])
      end
    end
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
