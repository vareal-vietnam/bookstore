module Users
  class BookRequestsController < ApplicationController
    def index
      @book_requests = User.find(params[:user_id])
                           .book_requests.order(created_at: :desc)
                           .includes(:book_request_images, :user)
                           .page(params[:page]).per(16)
    end

    def edit
      @book_request = BookRequest.find(params[:id])
    end
  end
end
