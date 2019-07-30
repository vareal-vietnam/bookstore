require 'rails_helper'
RSpec.describe BooksController, type: :controller do
  include_context 'generate book_params'

  let(:book) { create(:book, user_id: current_user.id) }

  describe '#update' do
    include_context 'logged in'

    context 'with valid book params' do
      before { put :update, params: { id: book.id, book: valid_book_params } }

      it 'the book has newest data' do
        expect(assigns(:book).name).to eql(book_params[:name])
        expect(assigns(:book).quantity).to eql(book_params[:quantity])
        expect(assigns(:book).price).to eql(book_params[:price])
        expect(assigns(:book).comment).to eql(book_params[:comment])
        expect(assigns(:book).description).to eql(book_params[:description])
      end

      it 'the book is given enough image file' do
        expect(book.images.count).to eql(image_files.count)
      end

      it 'get a success flash' do
        expect(flash.count).to equal(1)
        expect(flash[:success]).to eql(I18n.t('book.updated'))
      end

      it 'redirect to book' do
        expect(subject).to redirect_to(book)
      end
    end

    context 'with invalid book params' do
      before { put :update, params: { id: book.id, book: invalid_book_params } }

      it 'the book not be update' do
        assigns(:book).reload
        expect(assigns(:book).name).to eql(book.name)
        expect(assigns(:book).quantity).to eql(book.quantity)
        expect(assigns(:book).price).to eql(book.price)
        expect(assigns(:book).comment).to eql(book.comment)
        expect(assigns(:book).description).to eql(book.description)
      end

      it 'render to :edit' do
        expect(subject).to render_template(:edit)
      end
    end

    context 'book is updated with no images' do
      subject do
        put :update, params: { id: book.id, book: invalid_book_params }
      end

      it 'all book images are not changed' do
        expect { subject }.to_not change(book, :images)
      end
    end
  end
end
