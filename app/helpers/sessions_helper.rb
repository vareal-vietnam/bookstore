module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user?
    @current_user ||= User.find_by(id: session[:user_id])
    return if @current_user.present?
  end

  def logged_in?
    !current_user.nil?
  end
end
