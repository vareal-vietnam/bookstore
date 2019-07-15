class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    return if @user.present?

    flash[:danger] = 'User khong ton tai, moi ban dang nhap'
    redirect_to login_url
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :phone, :address, :password, :password_confirmation
    )
  end
end
