class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user
      login(@user.id)
      redirect_to home_path
    else
      flash.now[:alert] = 'There was something wrong with your login information'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have logged out'
    redirect_to root_path
  end
end
