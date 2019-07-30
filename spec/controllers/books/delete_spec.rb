require 'rails_helper'
RSpec.describe BooksController, type: :controller do
  describe "#delete user's book" do
    let!(:book) { create(:book, user_id: current_user.id) }
    include_context 'logged in'

    context 'current user remove book in the list' do
      subject { delete :destroy, params: { id: Book.last.id } }

      it 'the book quantity of reduce 1' do
        expect { subject }.to change(Book, :count).by(-1)
      end

      it 'flash for success removed' do
        subject
        expect(flash.count).to equal(1)
        expect(flash[:success]).to eql(I18n.t('book.removed'))
      end

      it 'redirect to current_user' do
        expect(subject).to redirect_to(current_user)
      end
    end
  end
end
