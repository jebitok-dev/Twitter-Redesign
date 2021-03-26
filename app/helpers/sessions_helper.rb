module SessionsHelper
  def sign_in_form
    render 'sign_in_form' if current_user.nil?
  end
end
