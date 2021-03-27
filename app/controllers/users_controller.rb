class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  # def edit
  # end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:info] = 'The user was saved successfully.'
      redirect_to login_path
    else
      flash[:info] = @user.errors.full_messages
      render :new
    end
  end
end

def show
  @user = User.find(params[:id])
end

  private

# Use callbacks to share common setup or constraints between actions.
# def set_user
#   @user = User.find(params[:id])
# end

# Only allow a list of trusted parameters through.
def user_params
  params.require(:user).permit(:username, :fullname, :photo, :coverImage, :createdAt)
end
