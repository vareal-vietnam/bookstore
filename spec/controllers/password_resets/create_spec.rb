require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  describe '#create' do
    let(:email) { 'ba@gmail.com' }
    let!(:user) { create(:user) }
    let(:password_reset) { { phone: user.phone, email: email } }

    subject do
      allow(ENV).to receive(:[])
        .with('HOST_URL').and_return('bookstorevareal-test.herokuapp.com')
      post :create, params: { password_reset: password_reset }
    end

    context 'User exist' do
      it 'return notify flash' do
        subject
        expect(flash.count).to eql(1)
        expect(flash[:info]).to eql(I18n.t('password_reset.notify'))
      end

      it 'Redirect to root path' do
        expect(subject).to redirect_to(root_path)
      end
    end

    context 'User not exist' do
      before { allow(User).to receive(:find_by).with(anything).and_return(nil) }
      it 'Return user not exist flash' do
        subject
        expect(flash.count).to eql(1)
        expect(flash[:danger]).to eql(I18n.t('users.not_exist'))
      end

      it 'Render new template' do
        expect(subject).to render_template(:new)
      end
    end
  end
end
