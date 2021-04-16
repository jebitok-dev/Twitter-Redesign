class OpinionsController < ApplicationController
  before_action :require_login, only: %i[create show index]

  def create
    # @opinion = current_user.opinions.build(opinion_params)
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
    # @opinion.increment!(:opinion_count)
  end

  def index
    @opinion = Opinion.new
  end

  def require_login
    redirect_to login_path unless current_user
  end

  private

  # Only allow a list of trusted parameters through.
  def opinion_param
    params.require('opinion').permit(:text)
  end
end
