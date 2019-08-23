module Users
  class BookRequestsController < ApplicationController
    before_action :authenticate_user!, only: %i[index]
    before_action :authorize_user!, only: %i[index]

    def index
      @book_requests =
        @user.book_requests.order(created_at: :desc)
      @book_requests = paginate_collection(@book_requests, params[:page], 16)
    end
  end
end
