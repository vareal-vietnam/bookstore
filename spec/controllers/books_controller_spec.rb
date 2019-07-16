require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  before do
    get :index
  end

  describe '#index' do
    context 'empty book' do
      it "assigns empty to books" do
        expect(assigns(:books)).to be_empty
      end
    end

    context 'has one book' do
      before do
        @book = create(:book)
      end

      it "assigns empty to books" do
        expect(assigns(:books).count).to equal(1)
        expect(assigns(:books).first.id).to equal(@book.id)
      end
    end

    context 'has many books' do
      before do
        @book_ids = []
        5.times do
          book = create(:book)
          @book_ids << book.id
        end
      end

      it "assigns empty to books" do
        expect(assigns(:books).count).to equal(@book_ids.count)
        expect(assigns(:books).pluck(:id)).to match_array(@book_ids)
      end
    end
  end
end
