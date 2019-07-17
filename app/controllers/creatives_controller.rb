class CreativesController < ApplicationController
  def index
    @most_reviewed_albums = Album.most_reviewed_albums
  end
end
