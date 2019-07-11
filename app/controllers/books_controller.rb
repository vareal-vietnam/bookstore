class BooksController < ApplicationController
  def index
    @books = Book.all.page(params[:page]).per(10)
  end

  def show
    @book = Book.find_by(id: book_path.match(/\d+\z/).to_s.to_i)
    @book_image = Image.where(book_id: @book.id)
  end
end
