module Users
  class BookRequestsController < ApplicationController
    before_action :check_login, only: %i[new edit index]
    def index
      @book_requests = book_requests_user.book_requests
                                         .order(created_at: :desc)
                                         .includes(:book_request_images, :user)
                                         .page(params[:page]).per(16)
    end

    def edit
      @book_request = BookRequest.find_by(params[:id])
    end

    private

    def book_requests_user
      User.find(params[:user_id])
    end

    def update
      @book_request = BookRequest.find(params[:id])
       if @book_request.update_attributes(book_request_params)
         redirect_to user_book_request_path @book_request
       end
    end
    private
      def book_request_params
        params.require(:book_request).permit(
          :name, :comment, :budget, :quantity, :book_request_images
        )
      end
      def check_login
        return if current_user
        flash[:danger] = t('not_found')
        redirect_to root_url
      end
  end
end
