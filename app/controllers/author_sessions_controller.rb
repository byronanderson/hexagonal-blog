class AuthorSessionsController < ApplicationController
  def new
    @author_session = AuthorSession.new
  end

  def create
    @author_session = AuthorSession.new(params[:author_session])
    if @author_session.valid?
      login!
      flash[:success] = "Logged in successfully"
      redirect_to root_path
    else
      flash.now[:error] = "Invalid credentials"
      render :new
    end
  end

  def destroy
    logout!
    redirect_to root_path
  end
end
