class UsersController < ApplicationController
  def index
    redirect_to root_path
  end

  def show
    if current_user
      @user = User.find_by(id: params[:id])
      return if @user.present?

      @user = User.find_by(id: current_user.id)
      flash[:warning] = t('.user_not_found')
    else
      flash[:danger] = t('not_found')
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :phone, :address, :password, :password_confirmation, :avatar
    )
  end
end
