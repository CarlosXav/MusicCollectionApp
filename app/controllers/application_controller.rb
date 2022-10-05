class ApplicationController < ActionController::Base
  
  # NOTE:
  #   These variables should be included in a .env file that would
  # not get pushed to the repository, in order to preserve the
  # access to the api in secrecy.
  #   However, since this is simply a test, I chose to keep them
  # as is, so as to not compromise the code functionality when it
  # is run by my evaluator, as well as its practicality.
  AUTH = "Basic ZGV2ZWxvcGVyOlpHVjJaV3h2Y0dWeQ=="
  API_URL = "https://europe-west1-madesimplegroup-151616.cloudfunctions.net/artists-api-controller"
  # -----------------------------------sorry for the wall of text!

  helper_method :current_user, :logged_in?, :get_artist_list
  def current_user
    
    session_uid = session[:user_id]
    
    if session_uid.nil?
      return false
    end
    
    return @current_user if @current_user
    
    c_user = User.find(session_uid)
    return c_user unless c_user.nil?
    
    session[:user_id] = nil
    return false
    
  end

  def logged_in?
    return !!current_user
  end

  def get_artist_list(artist_id)
    
    if artist_id.to_i <= 0
      response = HTTP.auth(AUTH).get(API_URL)
    else
      response = HTTP.auth(AUTH).get(
        API_URL,
        :params => {:artist_id => artist_id}
      )
    end

    data = JSON.parse(response.body)
    
    if data.nil?
      return false
    end

    artists = data['json']
    
    if artists.empty? || artists.nil?
      return false
    end

    if artist_id.to_i > 0
      artist = artists[0]
      return artist
    end

    better_list = []

    if artist_id.to_i <= 0
      artists.each do |artist|
        better_list << {
          'id' => artist[0]['id'],
          'name' => artist[0]['name'],
          'twitter' => artist[0]['twitter']
        }
      end
      return better_list
    end
        
    return false
  end
  
  def require_login
    unless logged_in?
      redirect_to login_path
    end
  end
  
  def require_admin
    unless current_user.admin
      flash[:notice] = "You need to be an administrator to do that."
      redirect_to root_path
    end
  end
  
  def require_root
    unless current_user.root
      flash[:notice] = "You need to be a super user to do that."
      redirect_to root_path
    end
  end
  
  
  def require_self_or_admin
    
    return true if current_user == @user || current_user.admin
    
    redirect_to login_path unless logged_in?

    flash[:notice] = "You do not have permission for that."
    
    redirect_to root_path
    
    return false

  end

end
