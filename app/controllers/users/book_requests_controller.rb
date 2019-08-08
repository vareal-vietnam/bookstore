module Users
  class BookRequestsController < ApplicationController
    before_action :authenticate_user!, only: %i[new edit index update]
    before_action :handle_invalid_user!, only: %i[edit update index]
    before_action :find_and_assign_book_request, only: %i[edit update]
    def index
      @book_requests = book_requests_user.book_requests
                                         .order(created_at: :desc)
                                         .includes(:book_request_images, :user)
                                         .page(params[:page]).per(16)
    end

    def edit
      return if current_user&.id == @book_request&.user_id

      set_not_found_flash_and_redirect
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

    private

    def book_requests_user
      User.find_by(params[:user_id])
    end

    def set_not_found_flash_and_redirect(message)
      flash[:danger] = message
      redirect_to(root_url) && return
    end

    def handle_invalid_user!
      set_not_found_flash_and_redirect unless
        current_user.id == params[:user_id].to_i
    end

    def authenticate_user!
      set_not_found_flash_and_redirect unless current_user
    end

    def find_and_assign_book_request
      @book_request = BookRequest.find_by(id: params[:id])
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
