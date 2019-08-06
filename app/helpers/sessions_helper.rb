module SessionsHelper
  def save_user_to_session(user)
    session[:user_id] = user.id
  end

  def current_user
    return @current_user if @current_user

    if session[:user_id]
      find_and_assign_by_session
    else
      find_and_assign_by_cookie
      save_user_to_session(@current_user) if @current_user
    end
  end

  def find_and_assign_by_session
    @current_user = User.find_by(id: session[:user_id])
  end

  def find_and_assign_by_cookie
    user = User.find_by(id: cookies.signed[:user_id])
    return unless user&.authenticated?(cookies[:remember_token])

    @current_user = user
  end

  def remember_user(user)
    user.generate_remember_token!
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget_user(user)
    user.remove_remember_digest
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
