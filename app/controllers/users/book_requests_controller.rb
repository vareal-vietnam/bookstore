module Users
  class BookRequestsController < ApplicationController
    before_action :authenticate_user!, only: %i[new edit index update]
    before_action :handle_invalid_user!, only: %i[edit update index]
    before_action :find_and_assign_book_request, only: %i[edit update destroy]
    def index
      @book_requests = book_requests_user.book_requests
                                         .order(created_at: :desc)
                                         .includes(:book_request_images, :user)
                                         .page(params[:page]).per(16)
    end

    def edit
      return if current_user&.id == @book_request&.user_id

      set_content_flash(t('warning.not_permission'), :danger)
      redirect(root_path)
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
      if @book_request.destroy
        set_content_flash(t('book_requests.delete.success'), :success)
      else
        set_content_flash(t('warning.book_request_not_exist'), :success)
      end
      redirect(user_book_requests_path(current_user))
    end

    private

    def book_requests_user
      User.find_by(id: params[:user_id])
    end

    def set_content_flash(flash_content, flash_type)
      flash[flash_type] = flash_content
    end

    def redirect(path)
      redirect_to(path) && return
    end

    def handle_invalid_user!
      user = book_requests_user
      if user
        set_content_flash(t('warning.not_permission'), :danger) unless
          current_user.id == params[:user_id].to_i
      else
        set_content_flash(t('warning.user_not_exist'), :danger)
      end
      redirect(root_path)
    end

    def authenticate_user!
      set_flash_and_redirect(t('require.log_in'), :danger, root_path) unless
        current_user
    end

    def find_and_assign_book_request
      @book_request = BookRequest.find_by(id: params[:id])
      binding.pry
      set_flash_and_redirect(t('warning.book_request_not_exist'), :danger, user_book_requests_url(current_user)) unless
        @book_request
      set_flash_and_redirect(t('warning.not_permission'), :danger, user_book_requests_url(current_user)) unless
        @book_request.user_id == current_user.id
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
