module SessionsHelper
  def assign_user_to_session(user)
    session[:user_id] = user.id
  end

  def current_user
    return @current_user if @current_user

    if session[:user_id]
      find_and_assign_by_session
    else
      find_and_assign_by_cookies
      assign_user_to_session(@current_user) if @current_user
    end
  end

  def find_and_assign_by_session
    @current_user = User.find_by(id: session[:user_id])
  end

  def find_and_assign_by_cookies
    user = User.find_by(id: cookies.signed[:user_id])
    return unless user&.authenticated?(cookies[:remember_token])

    @current_user = user
  end

  def remember_user_and_create_cookies(user)
    user.generate_remember_token_and_assign_to_remember_digest
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def not_remember_and_delete_cookies(user)
    user.remove_remember_digest_value
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
