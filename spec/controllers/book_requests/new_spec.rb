require 'rails_helper'
RSpec.describe BookRequestsController, type: :controller do
  describe '#new' do
    context 'before login' do
      before { get :new }

      it 'get a danger flash' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('warning.need_log_in'))
      end

      it 'return root page' do
        expect(subject).to redirect_to(root_url)
      end
    end
    context 'after login' do
      include_context 'logged in'

      it 'get a instace of Book Request' do
        get :new
        expect(assigns(:book_request)).to be_a(BookRequest)
      end
    end
  end
end
