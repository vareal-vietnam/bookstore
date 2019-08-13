require 'rails_helper'
RSpec.describe BookRequestsController, type: :controller do
  describe '#new' do
    before do
      get :new
    end

    it 'init new book instance' do
      expect(assigns(:book_request)).to be_a(BookRequest)
    end
  end
end
