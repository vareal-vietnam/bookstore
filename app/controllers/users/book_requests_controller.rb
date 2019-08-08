module Users
  class BookRequestsController < ApplicationController
    before_action :check_log_in, only: %i[new edit index update]
    before_action :check_valid_user, only: %i[edit update]
    before_action :find_and_assign_book_request, only: %i[edit]
    def index
      @book_requests = book_requests_user.book_requests
                                         .order(created_at: :desc)
                                         .includes(:book_request_images, :user)
                                         .page(params[:page]).per(16)
    end

    def edit
      return if current_user&.id == @book_request&.user_id

      handle_danger_flash
    end

    def update
      @book_request = BookRequest.find(params[:id])
      if @book_request.update_attributes(book_request_params)
        destroy_image_files unless image_file_params
        create_image_files
        flash[:success] = t('book_requests.update.success')
        redirect_to user_book_request_path @book_request
      else
        render 'edit'
      end
    end

    private

    def book_requests_user
      User.find(params[:user_id])
    end

    def handle_danger_flash
      flash[:danger] = t('not_found')
      redirect_to root_url
    end

    def check_valid_user
      handle_danger_flash unless current_user.id == params[:user_id].to_i
    end

    def check_log_in
      handle_danger_flash unless current_user
    end

    def find_and_assign_book_request
      @book_request = BookRequest.find_by(id: params[:id])
    end

    def book_request_params
      params.require(:book_request).permit(
        :name, :comment, :budget, :quantity
      )
    end

    def image_file_params
      params[:book_request][:book_request_images]
    end

    def create_image_files
      image_file_params&.each do |image_file|
        @book_request.book_request_images.create(file: image_file)
      end
    end

    def destroy_image_files
      file_images = @book_request.book_request_images
      file_images&.each do |image_file|
        image_file.destroy
      end
    end
  end
end
