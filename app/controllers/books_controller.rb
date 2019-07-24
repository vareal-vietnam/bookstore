class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
    @books = Book.all.includes(:images, :user).page(params[:page]).per(10)
  end

  def show
    @book = Book.find_by(id: params[:id])
    return if @book.present?

    flash[:danger] = t('not_found')
    redirect_to root_url
  end
end
