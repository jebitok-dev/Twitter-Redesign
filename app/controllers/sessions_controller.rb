class SessionsController < ApplicationController
  before_action :require_logout, only: %i[new create]
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(session_param)
    if @user
      login(@user.id)
      redirect_to home_path
    else
      flash.now[:message] = 'There was something wrong with your login information'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to login_path
  end

  def require_logout
    redirect_to home_path if current_user
  end

  private

  def session_param
    params.require('session').permit(:username)
  end
end
