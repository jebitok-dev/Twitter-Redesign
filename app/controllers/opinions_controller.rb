class OpinionsController < ApplicationController
  before_action :require_login, only: %i[create show index]

  def index
    @opinion = Opinion.new
    @opinions = Opinion.order('created_at DESC').includes(:Author).limit(5)
  end

  def create
    @opinion = Opinion.new(opinion_param)
    @opinion.author_id = current_user.id

    if @opinion.save
      current_user.opinion_count += 1
      current_user.save
      redirect_to home_path
    else
      render 'show'
    end
  end

  def show
    @opinion = Opinion.find(params[:id])
  end

  def require_login
    redirect_to login_path unless current_user
  end

  private

  # Only allow a list of trusted parameters through.
  def opinion_param
    params.require(:opinion).permit(:author_id, :text, :createdAt)
  end
end
