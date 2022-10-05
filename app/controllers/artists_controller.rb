class ArtistsController < ApplicationController
  before_action :require_login

  # GET artists
  def index
    @artists = get_artist_list(0)
  end
  
  # GET artist/1
  def show
    @artist = get_artist_list(params[:id])
    
    @albums = Album.where(artist: @artist['id'])
    if @albums.nil?
      @albums = []
    end

  end
  
end
