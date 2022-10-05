class AlbumsController < ApplicationController
  before_action :require_login, :setup_artist_list
  before_action :set_album, only: %i[ show edit update destroy ]
  before_action :set_user, only: %i[ edit update show destory]
  before_action :require_admin, only: %i[ destroy ]
  before_action :require_self_or_admin, only: %i[ edit update ]
  before_action :setup_artist_list_for_dropdown_list, only: %i[ new edit ]
  
  # GET /albums or /albums.json
  def index
    @albums = Album.all
  end

  # GET /albums/1 or /albums/1.json
  def show
    @album = Album.find(params[:id])
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit

  end

  # POST /albums or /albums.json
  def create
    @album = Album.new(album_params)
    @album.user = current_user
    respond_to do |format|
      if @album.save
        format.html { redirect_to album_url(@album), notice: "Album was successfully created." }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1 or /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to album_url(@album), notice: "Album was successfully updated." }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1 or /albums/1.json
  def destroy
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url, notice: "Album was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    def set_user
      @user = Album.find(params[:id]).user
      p "user: #{@user.to_s}, current_user: #{current_user.to_s}"
    end

    def setup_artist_list_for_dropdown_list
      artist_list = get_artist_list(0)
      @artists = {}
      artist_list.each do |artist| 
        @artists[artist['name']] = artist['id']
      end
    end

    def setup_artist_list
      @artists = get_artist_list(0)
    end
    

    # Only allow a list of trusted parameters through.
    def album_params
      album_params = params.require(:album).permit(:name, :artist, :description, :year, :user_id)
    end
end