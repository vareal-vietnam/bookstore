class BooksController < ApplicationController
  def index
    @books = Book.all.page(params[:page]).per(10)
  end

  def show
    @book = Book.find_by(id: params[:id])
    if @book.nil?
      flash[:danger] = "#{t('not_found')}"
      redirect_to books_url
    else
      @book_images = @book.images
    end
  end
end
