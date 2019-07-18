require 'rails_helper'
RSpec.describe BooksController, type: :controller do
  describe '#index' do
    before { get :index }
    context 'has no book' do
      it 'assigns empty to books' do
        expect(assigns(:books)).to be_empty
      end
    end

    context 'has one book' do
      before do
        # binding.pry
        @book = create(:book)
      end
      it 'assigns a book to books' do
        expect(assigns(:books).count).to equal(1)
        expect(assigns(:books).first.id).to equal(@book.id)
      end
    end

    context 'has many books' do
      before do
        user = create(:user)
        @book_ids = []
        5.times do
          book = create(:book, user_id: user.id)
          @book_ids << book.id
        end
      end

      it 'assigns many book to books' do
        expect(assigns(:books).count).to equal(@book_ids.count)
        expect(assigns(:books).pluck(:id)).to match_array(@book_ids)
      end
    end
  end

  describe '#show' do
    before do
      @book = create(:book)
      3.times do
        create(:image, book_id: @book.id)
      end
    end
    context 'find result' do
      it 'book found' do
        get :show, params: { id: @book.id }
        expect(assigns(:book).attributes).to eql(@book.attributes)
        expect(assigns(:book).user.attributes).to eql(@book.user.attributes)
        expect(assigns(:book).images.to_json).to eql(@book.images.to_json)
      end

      it 'book not found' do
        allow(Book).to receive(:find_by).with(anything).and_return(nil)
        get :show, params: { id: @book.id }
        expect(assigns(:book)).to equal(nil)
        expect(flash[:danger]).to eql(I18n.t('not_found'))
        expect(subject).to redirect_to(root_url)
      end
    end
  end
end
