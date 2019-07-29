class BookRequestsController < ApplicationController
  def new
    @book_request = BookRequest.new
  end

  def create
    @book_request = current_user.book_requests.build(book_request_params)
    if @book_request.save
      insert_data
      flash[:success] = t('.success')
      redirect_to root_url
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

  def insert_data
    images = params[:book_request][:book_request_images]
    images&.each do |image|
      @book_request.book_request_images.create(url: image)
    end
  end
end
