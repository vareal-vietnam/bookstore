class BooksController < ApplicationController
  def index
    @books = Book.all.page(params[:page]).per(10)
  end

  def show
    @book = Book.find_by(id: params[:id])
    @book_images = @book.images
  end
end
