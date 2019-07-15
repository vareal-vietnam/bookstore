class BooksController < ApplicationController
  def index
    @books = Book.all.includes(:images).page(params[:page]).per(10)
  end

  def show
    @book = Book.find_by(id: params[:id])
    if @book.nil
      @book_images = @book.images
    else
      flash[:danger] = t('not_found')
      redirect_to books_url
    end
  end
end
