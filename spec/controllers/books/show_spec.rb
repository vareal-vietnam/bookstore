require 'rails_helper'
RSpec.describe BooksController, type: :controller do
  include_context 'generate book_params'

  let(:book) { create(:book) }

  describe '#show' do
    context 'book is existing' do
      it "should be received book's info" do
        get :show, params: { id: book.id }
        expect(assigns(:book).attributes).to eql(book.attributes)
      end
    end

    context 'book is not existing' do
      before do
        allow(Book).to receive(:find_by).with(anything).and_return(nil)
        get :show, params: { id: book.id }
      end

      it 'should be received a nil object' do
        expect(assigns(:book)).to equal(nil)
      end

      it 'should be received a danger flash' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end

      it 'should be return root page' do
        expect(subject).to redirect_to(root_url)
      end
    end
  end
end
