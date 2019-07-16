require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe '#index'
    context 'have no book'
      it do
        get :index
        expect(assigns(:books)).to be_empty
      end
    end
  end
end
