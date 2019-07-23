class UsersController < ApplicationController
  def show
  end

  def new
    @user = User.new
  end

  def edit
    return if params[:id].to_i == current_user&.id

    flash[:danger] = t('not_found')
    redirect_to root_url
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

  def update
    if current_user.update_attributes(user_params)
      flash[:success] = t('.update_success')
      redirect_to current_user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :phone, :address, :password, :password_confirmation, :avatar
    )
  end
end
