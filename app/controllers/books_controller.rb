class BooksController < ApplicationController
  def new
    if current_user
      @book = Book.new
    else
      flash[:danger] = t('not_found')
      redirect_to root_url
    end
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      image_files_params&.each do |image_file|
        @book.images.create(file: image_file)
      end
      flash[:success] = t('books.created')
      redirect_to @book
    else
      render 'new'
    end
  end

  def index
    @books = Book.order(created_at: :desc)
                 .includes(:images, :user)
                 .page(params[:page]).per(10)
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

  def image_files_params
    params[:book][:files]
  end
end
