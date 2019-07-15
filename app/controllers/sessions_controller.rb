class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(phone: params[:session][:phone])
    if user&.authenticate(params[:session][:password])
      log_in user
      flash[:success] = t('.success_login')
      redirect_to user
    else
      flash[:warning] = t('.wrong_password')
      render 'new'
    end
  end

  def destroy
  end
end
