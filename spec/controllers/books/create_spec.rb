require 'rails_helper'
RSpec.describe BooksController, type: :controller do
  include_context 'generate book_params'

  describe '#create' do
    include_context 'logged in'

    context 'with valid book_params' do
      subject { post :create, params: { book: valid_book_params } }

      it 'the number of book is increment by 1' do
        expect { subject }.to change(Book, :count).by(1)
      end

      it 'new book is created with correct data' do
        subject
        expect(Book.last.attributes).to include(book_params.stringify_keys)
      end

      it 'new book is given enough image file' do
        subject
        expect(Book.last.images.count).to eql(image_files.count)
      end

      it 'get a success flash' do
        subject
        expect(flash.count).to equal(1)
        expect(flash[:success]).to eql(I18n.t('books.created'))
      end

      it 'redirect to new book' do
        expect(subject).to redirect_to(Book.last)
      end
    end

    context 'with invalid book_params' do
      subject { post :create, params: { book: invalid_book_params } }

      it 'the number of book is constant' do
        expect { subject }.to_not change(Book, :count)
      end

      it "should be reder to 'new'" do
        expect(subject).to render_template(:new)
      end
    end
  end
end
