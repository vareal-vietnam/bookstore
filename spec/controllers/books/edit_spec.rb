require 'rails_helper'
RSpec.describe BooksController, type: :controller do
  include_context 'generate book_params'

  describe '#edit' do
    context 'before login' do
      before do
        book = create(:book)
        get :edit, params: { id: book.id }
      end

      it 'return root page' do
        expect(subject).to redirect_to(root_url)
      end

      it 'get a danger flash' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end
    end

    context 'with invalid book' do
      include_context 'logged in'
      before do
        allow(Book).to receive(:find_by).with(anything).and_return(nil)
        get :edit, params: { id: 1 }
      end

      it 'return root page' do
        expect(subject).to redirect_to(root_url)
      end

      it 'get a danger flash' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end
    end

    context "current_user not be book's owner" do
      include_context 'logged in'
      let(:user) { create(:user) }
      let(:book) { create(:book, user_id: user.id) }
      before do
        get :edit, params: { id: book.id }
      end

      it 'return root page' do
        expect(subject).to redirect_to(root_url)
      end

      it 'get a danger flash' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end
    end

    context "after login as book's owner" do
      include_context 'logged in'
      let(:book) { create(:book, user_id: current_user.id) }
      before do
        get :edit, params: { id: book.id }
      end
      it 'get the correct book' do
        expect(assigns(:book).attributes).to eql(book.attributes)
      end
    end
  end
end
