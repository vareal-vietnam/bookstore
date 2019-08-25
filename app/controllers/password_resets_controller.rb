class PasswordResetsController < ApplicationController
  before_action :get_user, only: %i[edit update]
  before_action :check_input, only: %i[update]
  before_action :check_expiration, only: %i[edit update]

  def create
    user = User.find_by(phone: params[:password_reset][:phone])
    if user
      user.send_password_reset(user.phone, params[:password_reset][:email])
      set_flash_and_redirect(:info, 'check email please', root_path)
    else
      flash[:danger] = t('users.not_exist')
      render 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      @user.update_attribute(:password_reset_token, nil)
      set_flash_and_redirect(:success, t('password_reset.sucess'), root_path)
    end
  end

  def user_params
     params.require(:user).permit(:password, :password_confirmation)
  end

  private

  def check_expiration
    if !@user.password_reset_expired?
      set_flash_and_redirect(:danger, t('password_reset.expried'),new_password_reset_path)
    end
  end

  def get_user
    return if @user = User.find_by(password_reset_token: params[:id])

    set_flash_and_redirect(:danger, t('users.not_exist'), root_path)
  end

  private

  def check_input
    if params[:user][:password].empty?
      @user.errors.add(:password, t('password_reset.password_empty'))
    else
      @user.errors.add(:password, t('password_reset.passwor_not_match')) unless
        params[:user][:password].eql?(params[:user][:password_confirmation])
    end
    render 'edit'
    return
  end
end
