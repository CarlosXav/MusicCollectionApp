class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully. Welcome back, #{user.first_name} #{user.last_name}."
      redirect_to artists_path
    else
      flash.now[:notice] = "Sorry, we couldn't find an account with this username and/or password. Please check that you're using the right username and/or password and try again."
      render 'new', status: :unprocessable_entity
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out successfully"
    redirect_to root_path
  end
  
end
