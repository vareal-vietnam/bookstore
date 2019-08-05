class BookRequestsController < ApplicationController
  def new
    @book_request = BookRequest.new
  end

  def create
    @book_request = current_user.book_requests.build(book_request_params)
    if @book_request.save
      save_images_to_book_request
      flash[:success] = t('.success')
      redirect_to @book_request
    else
      render 'new'
    end
  end

  def index
    @book_requests =
      BookRequest.order(created_at: :desc).page(params[:page]).per(16)
  end

  private

  def book_request_params
    params.require(:book_request).permit(
      :name, :comment, :budget, :quantity, :book_request_images
    )
  end

  def save_images_to_book_request
    image_files = params[:book_request][:book_request_images]
    image_files&.each do |image_file|
      @book_request.book_request_images.create(file: image_file)
    end
  end
end
