class OpinionsController < ApplicationController
  before_action :authorize, only: [:index]

  def index
    @opinion = Opinion.new
    @opinions = Opinion.all.order('created_at DESC')
    @users = User.all_users(current_user.id).order('created_at DESC')
  end

  def create
    @opinion = Opinion.new(opinion_params)
    @opinion.author_id = current_user.id

    if @opinion.save
      flash[:info] = 'The opinion was created successfully.'
      redirect_to root_path
    else
      flash[:info] = @opinions.errors.full_messages
      render 'index'
    end
  end

  def show
    @opinion = Opinion.find(params[:id])
    @users = User.all
  end

  private

  # Only allow a list of trusted parameters through.
  def opinion_params
    params.require(:opinion).permit(:author_id, :text, :createdAt)
  end
end
