class BookRequestsController < ApplicationController
  def new
    @book_request = BookRequest.new
  end

  def create
    @book_request = current_user.book_requests.build(book_request_params)
    if @book_request.save
      upload_images
      flash[:success] = t('.success')
      redirect_to @book_request
    else
      render 'new'
    end
  end

  private

  def book_request_params
    params.require(:book_request).permit(
      :name, :comment, :budget, :quantity, :user_id, :book_request_images
    )
  end

  def upload_images
    files = params[:book_request][:book_request_images]
    files&.each do |file|
      @book_request.book_request_images.create(file: file)
    end
  end
end
