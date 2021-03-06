class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end 
  
  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end 
  
  def request_redirect(path)
    if request.referer
      redirect_to request.referer
    else
      redirect_to path
    end
  end 
  
  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "Only admin users can perform that action"
      request_redirect(root_path)
    end
  end
  
end
