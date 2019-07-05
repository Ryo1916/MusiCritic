class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :destroy]
  before_action :authenticate_user!

  def index
    @albums = Album.all.order(name: 'ASC')
    if params[:album_name]
      @albums = Album.search_album(album_name: params[:album_name])

      # もしartistがDBに存在しない場合、albumを保存する前にAPIからデータ取得して保存する
      if @albums.empty?
        albums = Album.search_album_from_api(album_name: params[:album_name])
        albums.each do |album|
          album.artists.each do |artist|
            if Artist.find_by(name: artist.name).nil?
              artists = Artist.search_artist_from_api(artist_name: artist.name)
              Artist.save_artist(artists: artists, artist_name: artist.name)
            end
          end
        end
        @albums = Album.save_album(albums: albums, album_name: params[:album_name])
      end
    end
  end

  def show
    @album = Album.find(params[:id])
    @reviews = Review.where(album_id: @album.id).order("created_at desc")

    if @reviews.blank?
      @avg_rating = 0
    else
      @avg_rating = @reviews.average(:rating).round(2)
      # average: tooutput average rating
      # round(2): round off to two decimal places
    end
  end

  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end
end
