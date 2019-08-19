module Users
  class BooksController < ApplicationController
    before_action :find_and_assign_book, only: %i[destroy]
    before_action :find_and_assign_user_books, only: %i[destroy index]
    before_action :authorize_user!, only: %i[index]

    def index
    end

    def destroy
      if @book.destroy
        flash[:success] = t('book.removed')
      else
        flash[:danger] = t('book.removed_fail')
      end
      redirect_to "#{user_books_path}?page=#{params[:page]}"
    end

    private

    def find_and_assign_book
      @book = Book.find_by(id: params[:id])
    end

    def find_and_assign_user_books
      if current_user
        @user_books = current_user.books.order(created_at: :desc)
                                  .includes(:images, :user)
        @user_books = paginate_collection(@user_books, params[:page], 10)
      else
        flash[:danger] = t('not_found')
        redirect_to root_url
      end
    end
  end
end
