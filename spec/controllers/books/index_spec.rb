require 'rails_helper'
RSpec.describe BooksController, type: :controller do
  include_context 'generate book_params'

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

      it 'should be received enough book' do
        expect(assigns(:books).count).to equal(Book.count)
      end

      it 'should be received correct book' do
        expect(assigns(:books).pluck(:id)).to match_array(Book.all.pluck(:id))
      end
    end
  end
end
