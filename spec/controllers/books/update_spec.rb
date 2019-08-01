require 'rails_helper'
RSpec.describe BooksController, type: :controller do
  include_context 'generate book_params'

  let(:book) { create(:book, user_id: current_user.id) }

  describe '#update' do
    include_context 'logged in'

    context 'with valid book params' do
      before { put :update, params: { id: book.id, book: valid_book_params } }

      it 'the book has newest data' do
        expect(assigns(:book).attributes).to include(book_params.stringify_keys)
      end

      it 'the book is given enough image file' do
        expect(book.images.count).to eql(image_files.count)
      end

      it 'get a success flash' do
        expect(flash.count).to equal(1)
        expect(flash[:success]).to eql(I18n.t('book.updated'))
      end

      it 'redirect to current_user' do
        expect(subject).to redirect_to(current_user)
      end
    end

    context 'with invalid book params' do
      subject do
        put :update, params: { id: book.id, book: invalid_book_params }
      end

      it 'the book not be update' do
        expect { subject }.to_not change(book, :reload)
      end

      it 'render to :edit' do
        subject
        expect(subject).to render_template(:edit)
      end
    end

    context 'book is updated with no images' do
      subject do
        put :update, params: {
          id: book.id,
          book: valid_book_params_without_images
        }
      end

      it 'the book has newest data' do
        subject
        expect(assigns(:book).attributes).to include(book_params.stringify_keys)
      end

      it 'all book images are not changed' do
        expect { subject }.to_not change(book, :images)
      end

      it 'redirect to current_user' do
        expect(subject).to redirect_to(current_user)
      end
    end
  end
end
