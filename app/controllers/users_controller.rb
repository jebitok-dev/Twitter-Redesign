class UsersController < ApplicationController
  before_action :require_login, only: %i[show follow_user edit update]
  before_action :require_logout, only: %i[new create]
  before_action :set_user, only: [:show]
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

  def show
    @user = User.includes(:user_followers).includes(:user_followings).includes(:created_opinions).find(params[:id])
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)

    @user.username = user_param[:username]
    @user.fullname = user_param[:fullname]

    if @user.save
      flash[:success] = 'Profile updated!'
      redirect_to edit_user_path(current_user.id)
    else
      flash.now[:message_edit] = @user.errors.full_messages
      render 'edit'
    end
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

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require('user').permit(:username, :fullname)
  end
end
