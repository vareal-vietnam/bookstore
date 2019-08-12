require 'rails_helper'
RSpec.describe Users::BooksController, type: :controller do
  describe '#destroy' do
    context 'not login' do
      subject { delete :destroy, params: { user_id: 2, id: 2 } }

      it 'returns to root url' do
        expect(subject).to redirect_to(root_url)
      end
    end

    context 'already login' do
      include_context 'logged in'

      let!(:book) { create(:book, user_id: current_user.id) }
      let(:page) { 10 }

      subject do
        delete :destroy, params: {
          user_id: current_user.id, id: Book.last.id, page: page
        }
      end

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
          expect(subject).to redirect_to("#{user_books_path}?page=#{page}")
        end
      end

      context 'current user remove book fail' do
        subject do
          delete :destroy, params: {
            user_id: current_user.id, id: Book.last.id, page: page
          }
        end

        before do
          allow_any_instance_of(Book).to receive(:destroy).and_return(false)
        end

        it 'flash for removed fail' do
          subject
          expect(flash.count).to equal(1)
          expect(flash[:danger]).to eql(I18n.t('book.removed_fail'))
        end

        it 'redirect to current_user' do
          expect(subject).to redirect_to("#{user_books_path}?page=#{page}")
        end
      end
    end
  end
end
