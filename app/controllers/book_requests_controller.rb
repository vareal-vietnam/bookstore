class BookRequestsController < ApplicationController
  def new
    @book_request = BookRequest.new
  end

  def create
    if current_user
      @book_request = current_user.book_requests.build(book_request_params)
      if @book_request.save
          flash[:new_request] = "create new book request success"
          images = params[:book_request][:book_request_images]
          images.each do |file|
            @book_request.book_request_images.create(url: file)
          end
        redirect_to root_url
      end
    else
      redirect_to new_session_url
    end
  end

  private

    def book_request_params
      params.require(:book_request).permit(
        :name, :comment, :budget, :quantity, :user_id, :book_request_images
      )
    end
end
