require 'rails_helper'
RSpec.describe BooksController, type: :controller do
  let(:n) { rand(100) }
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
          create(:book)
        end
      end

      it 'assigns many book to books' do
        expect(assigns(:books).count).to equal(Book.count)
        expect(assigns(:books).pluck(:id)).to match_array(Book.all.pluck(:id))
      end
    end
  end

  describe '#show' do
    before do
      @book = create(:book)
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

  describe "#delete user's book" do
    include_context 'logged in'
    context 'current user remove book in the list' do
      before do
        n.times do
          @book = create(:book, user_id: current_user.id)
        end
      end
      # destroy(@book_first)
      # @book_last.destroy
      it 'the book quantity of current user reduce 2' do
      binding.pry
        expect(current_user.books.count).to eql(98)
      end

      it 'the first book is remove' do
        expect(@book_first). to eql(nil)
      end
      it 'the second book is removed' do
        expect(@book_second). to eql(nil)
      end
    end
  end





end
