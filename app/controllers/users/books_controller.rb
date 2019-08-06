module Users
  class BooksController < ApplicationController
    before_action :find_and_assign_book, only: %i[destroy]
    before_action :find_and_assign_user_books, only: %i[destroy index]

    def index
    end

    def destroy
      if @book.destroy
        flash.now[:success] = t('book.removed')
      else
        flash.now[:danger] = t('book.removed_fail')
      end
      render layout: false
    end

    private

    def find_and_assign_book
      @book = Book.find_by(id: params[:id])
    end

    def find_and_assign_user_books
      if current_user
        @user_books = current_user.books.order(created_at: :desc)
                                  .includes(:images, :user)
                                  .page(params[:page]).per(10)
      else
        flash[:success] = t('not_found')
        redirect_to root_url
      end
    end
  end
end
