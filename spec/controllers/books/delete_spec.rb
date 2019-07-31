require 'rails_helper'
RSpec.describe BooksController, type: :controller do
  describe "#delete user's book" do
    include_context 'logged in'
    let!(:book) { create(:book, user_id: current_user.id) }
    subject { delete :destroy, params: { id: Book.last.id } }

    context 'current user remove book sucessful' do
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

    context 'current user remove book fail' do
      subject { delete :destroy, params: { id: Book.last.id } }
      before do
        allow_any_instance_of(Book).to receive(:destroy).and_return(false)
      end

      it 'flash for removed fail' do
        subject
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('book.removed_fail'))
      end

      it 'redirect to current_user' do
        expect(subject).to redirect_to(current_user)
      end
    end
  end
end
