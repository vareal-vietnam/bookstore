require 'rails_helper'
RSpec.describe BookRequestsController, type: :controller do
  describe '#new' do
    context 'before login' do
      before { get :new }

      it 'get a danger flash' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('require.log_in'))
      end

      it 'return root page' do
        expect(subject).to redirect_to(root_url)
      end
    end

    context 'after login' do
      include_context 'logged in'
      before do
        get :new
      end

      it 'init new book instance' do
        expect(assigns(:book_request)).to be_a(BookRequest)
      end
    end
  end
end
