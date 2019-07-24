class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      images_params.each do |image|
        @book.images.create(file: image)
      end
      flash[:sucsess] = t('books.created')
      redirect_to @book
    else
      render 'new'
    end
  end

  def index
    @books = Book.order(created_at: :desc).includes(:images, :user).page(params[:page]).per(10)
  end

  def show
    @book = Book.find_by(id: params[:id])
    return if @book.present?

    flash[:danger] = t('not_found')
    redirect_to root_url
  end

  private

  def book_params
    params.require(:book).permit(
      :name, :description, :price, :quantity, :comment
    )
  end

  def images_params
    params[:book][:files]
  end
end
