module SessionsHelper
  def login(user_id)
    session[:user_id] = user_id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue StandardError # rubocop:disable Lint/SuppressedException
  end

  def logged_in?
    !current_user.nil?
  end

  def logout
    session.delete(:user_id)
  end
end
