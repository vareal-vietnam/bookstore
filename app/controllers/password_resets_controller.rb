class PasswordResetsController < ApplicationController
  before_action :check_valid_url, only: %i[edit update]
  before_action :check_user_exist, only: %i[create]
  before_action :check_password_match, only: %i[update]

  def create
    @user.send_password_reset(@user.phone, params[:password_reset][:email])
    set_flash_and_redirect(:info, t('password_reset.notify'), root_path)
  end

  def update
    if @user.update_attributes(user_params)
      @user.update_attribute(:password_reset_token, nil)
      set_flash_and_redirect(:success, t('password_reset.sucess'), root_path)
    else
      flash[:danger] = t('password_reset.error')
      render('edit')
    end
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  private

  def check_valid_url
    @user = User.find_by(password_reset_token: params[:id])
    return if @user&.password_reset_expired?

    set_flash_and_redirect(
      :danger, t('password_reset.invalid_url'), new_password_reset_path
    )
  end

  def check_password_match
    password_confirmation = user_params[:password_confirmation]
    password = user_params[:password]
    return if password_confirmation.eql?(password)

    flash[:danger] = t('password_reset.password_not_match')
    render('edit') && return
  end

  def check_user_exist
    @user = User.find_by(phone: params[:password_reset][:phone])
    return if @user

    flash[:danger] = t('users.not_exist')
    render('new') && return
  end
end
