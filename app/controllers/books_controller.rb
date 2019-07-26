class BooksController < ApplicationController
  before_action :find_and_assign_book, only: %i[show edit update]

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
      update_book_images
      flash[:success] = t('books.created')
      redirect_to @book
    else
      render 'new'
    end
  end

  def edit
    # TODO
    # Refactor later
    return if @book && current_user && current_user&.id == @book&.user_id

    flash[:danger] = t('not_found')
    redirect_to root_url
  end

  def update
    if @book.update_attributes(book_params)
      if image_files_params.present?
        destroy_book_images
        update_book_images
      end
      flash[:success] = t('book.updated')
      redirect_to @book
    else
      render 'edit'
    end
  end

  def index
    @books = Book.order(created_at: :desc)
                 .includes(:images, :user)
                 .page(params[:page]).per(10)
  end

  def show
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

  def update_book_images
    image_files_params&.each do |image_file|
      @book.images.create(file: image_file)
    end
  end

  def find_and_assign_book
    @book = Book.find_by(id: params[:id])
  end

  def destroy_book_images
    @book.images&.each do |book_image|
      book_image.destroy
    end
  end
end
