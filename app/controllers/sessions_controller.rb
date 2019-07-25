class SessionsController < ApplicationController
  def new
    redirect_to root_url if current_user
  end

  def create
    if logging_user&.authenticate(params[:session][:password])
      log_in logging_user
      flash[:success] = t('.success_login')
      redirect_to logging_user
    else
      flash[:warning] = t('.wrong_password')
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url
  end

  private

  def logging_user
    @logging_user ||= User.find_by(phone: params[:session][:phone])
  end
end
