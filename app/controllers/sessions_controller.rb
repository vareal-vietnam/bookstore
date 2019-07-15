class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(phone: params[:session][:phone])
    if user &.authenticate(params[:session][:password])
      log_in user
      flash[:success] = 'Dang nhap thanh cong!'
      redirect_to user
    else
      flash[:warning] = 'Ban da nhap sai So dien thoai/password'
      render 'new'
    end
  end

  def destroy
  end
end
