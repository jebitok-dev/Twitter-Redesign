class OpinionsController < ApplicationController
  def index
    @opinions = Opinion.all
  end

  def new
    @opinion = Opinion.new
  end

  def create
    @opinion = current_user.events.build(opinion_params)
    if @opinion.save
      flash[:info] = 'The opinion was created successfully.'
      redirect_to opinions_path
    else
      flash[:info] = @opinions.errors.full_messages
      render :new
    end
  end

  def show
    @opinion = Opinion.find(params[:id])
    @users = User.all
  end

  def add_user_to_opinion(user)
    redirect_to user
  end
  helper_method :add_user_to_opinion

  private

  # Only allow a list of trusted parameters through.
  def opinion_params
    params.require(:opinion).permit(:author_id, :text, :createdAt)
  end
end
