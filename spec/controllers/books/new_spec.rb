require 'rails_helper'
RSpec.describe BooksController, type: :controller do
  include_context 'generate book_params'

  describe '#new' do
    context 'after login' do
      include_context 'logged in'

      it 'get a instace of Book' do
        get :new
        expect(assigns(:book)).to be_a(Book)
      end
    end

    context 'before login' do
      before { get :new }

      it 'get a danger flash' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end

      it 'return root page' do
        expect(subject).to redirect_to(root_url)
      end
    end
  end
end
