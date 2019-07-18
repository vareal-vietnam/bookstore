require 'rails_helper'
RSpec.describe BooksController, type: :controller do
  describe '#index' do
    before { get :index }
    context 'has no book' do
      it 'assigns empty to books' do
        expect(assigns(:books)).to be_empty
      end
    end

    context 'has many books' do
      before do
        3.times do
          user = create(:user)
          3.times do
            create(:book, user_id: user.id)
          end
        end
      end

      it 'assigns many book to books' do
        binding.pry
        expect(assigns(:books).pluck(:id)).to match_array(Book.all.pluck(:id))
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
