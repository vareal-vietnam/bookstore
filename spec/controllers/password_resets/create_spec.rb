require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  let(:phone) {'0123456789'}
  let(:email) {'rspec@gmail.com'}

  before do
    user = create(:user, phone: phone)
  end

  context 'User is found' do
    subject do
      get :create, params: { phone: phone, email: email }
    end
  end
end
