module Users
  class BookRequestsController < ApplicationController
    before_action :authenticate_user!, only: %i[new edit index update]
    before_action :authorize_user!, only: %i[edit update index]
    before_action :find_and_assign_book_request, only: %i[edit update destroy]
    def index
      @book_requests =
        @user.book_requests.order(created_at: :desc)
             .includes(:book_request_images, :user)
             .page(params[:page]).per(16)
    end

    def edit
      path = user_book_requests_path(current_user)
      if @book_request
        return if current_user.id == @book_request.user_id

        set_flash_and_redirect(t('require.permission'), :danger, path) unless
          current_user.id == @book_request.user_id
      else
        set_flash_and_redirect(t('book_request.not_exist'), :danger, path)
      end
    end

    def update
      if @book_request.update_attributes(book_request_params)
        destroy_image_files unless image_files_params
        create_image_files
        flash[:success] = t('book_requests.update.success')
        redirect_to user_book_request_path(current_user, @book_request)
      else
        render 'edit'
      end
    end

    def destroy
      path = user_book_requests_path(current_user)
      if @book_request
        if @book_request.destroy
          set_flash_and_redirect(t('action.delete.success'), :success, path)
        else
          set_flash_and_redirect(t('action.delete.fail'), :danger, path)
        end
      else
        set_flash_and_redirect(t('book_requests.not_exist'), :danger, path)
      end
    end

    private

    def set_content_flash(flash_content, flash_type)
      flash[flash_type] = flash_content
    end

    def redirect(path)
      redirect_to(path) && return
    end

    def authorize_user!
      @user = User.find_by(id: params[:user_id])
      return if @user && @user.id == current_user.id

      set_flash_and_redirect(t('require.permission'), :danger, root_path)
    end

    def authenticate_user!
      set_flash_and_redirect(t('require.log_in'), :danger, root_path) unless
        current_user
    end

    def find_and_assign_book_request
      @book_request = BookRequest.find_by(id: params[:id])
    end

    def set_flash_and_redirect(flash_content, flash_type, path)
      set_content_flash(flash_content, flash_type) && redirect(path)
    end

    def book_request_params
      params.require(:book_request).permit(
        :name, :comment, :budget, :quantity
      )
    end

    def image_files_params
      params[:book_request][:book_request_images]
    end

    def create_image_files
      image_files_params&.each do |image_file|
        @book_request.book_request_images.create(file: image_file)
      end
    end

    def destroy_image_files
      file_images = @book_request.book_request_images
      file_images.destroy_all if file_images.present?
    end
  end
end
