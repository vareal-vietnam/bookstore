class BooksController < ApplicationController
  def index
    @books = Book.all.page(params[:page]).per(10)
    # binding.pry
  end
end
