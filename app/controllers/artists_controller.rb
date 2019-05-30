class ArtistsController < ApplicationController
  before_action :set_artist, only: [:destroy]
  before_action :authenticate_user!

  def index
    @artists = Artist.all.order(name: 'ASC')
    if params[:search]
      @artists = Artist.search_artist(artist_name: params[:search])
      Artist.save_data_from_api(artist_name: params[:search]) if @artists.empty?
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
