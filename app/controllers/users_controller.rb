class UsersController < ApplicationController
  before_action :require_login, only: %i[show follow_user edit update]
  before_action :require_logout, only: %i[new create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to home_path
      login(@user.id)
    else
      flash.now[:error_messages] = @user.errors.full_messages
      render 'new'
    end
  end
end

def show
  @user = User.includes(:user_followers).includes(:user_followings).include(:created_opinions).find(params[:id])
end

def edit
  @user = User.find(current_user.id)
end

def follow_user
  current_user.follow_user(params[:id])
  redirect_to user_path(params[:id])
end

def require_login
  redirect_to login_path unless current_user
end

def require_logout
  redirect_to home_path if current_user
end

private

def user_params
  params.require(:user).permit(:username, :fullname)
end
