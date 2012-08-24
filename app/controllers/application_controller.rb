class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def require_author
    if not logged_in?
      flash[:error] = "Access denied"
      redirect_to root_path
    end
  end

  def logged_in?
    session[:logged_in] == true
  end

  def login!
    session[:logged_in] = true
  end

  def logout!
    session[:logged_in] = nil
  end
end
