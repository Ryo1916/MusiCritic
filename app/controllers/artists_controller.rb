class ArtistsController < ApplicationController
  before_action :set_artist, only: [:destroy]
  before_action :authenticate_user!

  def index
    if params[:search]
      @artists = RSpotify::Artist.search(params[:search])
    else
      @artists = Artist.all
    end

    # if the artist exists our database
    # @artists = Artist.all
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
