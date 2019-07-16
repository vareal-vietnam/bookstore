class SessionsController < ApplicationController
  before_action :find_user, only: [:create]

  def new
  end

  def create
    if @user&.authenticate(params[:session][:password])
      log_in @user
      flash[:success] = t('.success_login')
      redirect_to @user
    else
      flash[:warning] = t('.wrong_password')
      render 'new'
    end
  end

  def destroy
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end

private
def find_user
  @user = User.find_by(phone: params[:session][:phone])
end
