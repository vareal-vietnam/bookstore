module Users
  class BookRequestsController < ApplicationController
    def index
      @book_requests = book_requests_user
    end

    def edit
      @book_request = BookRequest.find_by(params[:id])
    end

    def book_requests_user
      User.find(params[:user_id])
          .book_requests.order(created_at: :desc)
          .includes(:book_request_images, :user)
          .page(params[:page]).per(16)
    end
  end
end
