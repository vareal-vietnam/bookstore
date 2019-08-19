module RequestHelper
  def authorize_user!
    @user = User.find_by(id: params[:user_id])
    return if @user && @user.id == current_user.id

    set_flash_and_redirect(:danger, t('require.permission'), root_path)
  end

  def authenticate_user!
    set_flash_and_redirect(:danger, t('require.log_in'), root_path) unless
      current_user
  end

  def find_and_assign_book_request
    @book_request = BookRequest.find_by(id: params[:id])
  end

  def set_flash_and_redirect(flash_type, flash_content, path)
    flash[flash_type] = flash_content
    redirect_to(path) && return
  end
end
