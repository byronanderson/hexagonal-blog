class AuthorSessionsController < ApplicationController
  def new
    @author_session = AuthorSession.new
  end

  def create
    @author_session = AuthorSession.new(params[:author_session])
    if @author_session.valid?
      session[:logged_in] = true
    else
      flash.now[:error] = "Invalid credentials"
      render :new
    end
  end

  def destroy
    session[:logged_in] = nil
  end
end
