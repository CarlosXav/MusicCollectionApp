class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_login, only: %i[ index show edit update destroy ]
  before_action :require_self_or_admin, only: %i[ destroy edit update ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @artists = get_artist_list(0)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if @user.root && !current_user.root
      redirect_to root_path, notice: "Only a root user can edit another root user"
    end
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.admin = false
    @user.root = false
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to artists_path, notice: "Sign up successful. Welcome, #{@user.username}. You are logged in." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        
        if current_user.root
          @user.root = params[:root]
          @user.admin = params[:admin]
        end

        format.html { redirect_to user_url(@user), notice: "User information was successfully updated." }
        format.json { render :show, status: :ok, location: @user }

      else

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    # only root user can delete other root users
    if (@user.root && current_user.root) || !@user.root
      # log the user out if the user deleted is the currently logged in user.
      session[:user_id] = nil if @user.id == session[:user_id]
      @user.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Account successfully terminated." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Only a root user can delete another root user." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      
      unless logged_in?
        return params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
      end

      if current_user.root
        return params.require(:user).permit(:first_name, :last_name, :email, :username, :password, :admin, :root)
      end

      return params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
      
    end
end
