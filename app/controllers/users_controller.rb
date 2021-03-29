class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:info] = 'The user was saved successfully.'
      redirect_to root_path
    else
      flash[:info] = @user.errors.full_messages
      render :new
    end
  end
end

def show
  @user = User.find(params[:id])
  @opinions = @user.opinions.order('created_at DESC').limit(5)
end

private

def user_params
  params.require(:user).permit(:username, :fullname, :photo, :coverImage, :createdAt)
end
