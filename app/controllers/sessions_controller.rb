class SessionsController < ApplicationController
  def new
    @previous_redirect = params[:previous_redirect]
    redirect_to root_url if current_user
  end

  def create
    @previous_redirect = params[:session][:previous_redirect]

    if valid_account?
      continue_authenticate_user
    else
      flash.now[:warning] = t('.wrong_password')
      render 'new'
    end
  end

  def destroy
    forget_user(current_user)
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url
  end

  def valid_account?
    logging_user&.authenticate(params[:session][:password])
  end

  def check_remember_me?
    params[:session][:remember_me] == '1'
  end

  private

  def continue_authenticate_user
    save_user_to_session logging_user
    remember_user(logging_user) if check_remember_me?
    flash[:success] = t('.success_login')
    redirect_to redirect_path
  end

  def redirect_path
    @previous_redirect.present? ? @previous_redirect : logging_user
  end

  def logging_user
    @logging_user ||= User.find_by(phone: params[:session][:phone])
  end
end
