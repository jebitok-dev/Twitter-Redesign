class FollowController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)

    redirect_to root_path
  end

  def destroy
    user = User.find(params[:id])
    current_user.unfollow(user)

    redirect_to root_path
  end

  def current_user
    User.find(session[:id])
  end
end
