require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  let(:token) {  SecureRandom.urlsafe_base64.split('.').join }
  let(:request_sent_at) { Time.zone.now }
  let!(:user) { create(:user) }
  describe '#edit' do
    subject do
      get :edit, params: {id: token}
    end

    before { user.update_attribute(:password_reset_token, token) }

    context 'User is found' do
      context 'The url is unexpire' do
        before { user.update_attribute(:password_reset_sent_at, request_sent_at) }

        it 'Render edit template' do
          expect(subject).to render_template(:edit)
        end
      end

      context 'User is expire' do
        before { user.update_attribute(:password_reset_sent_at, request_sent_at - 2.5.hours) }

        it 'Return expired flash' do
          subject
          expect(flash.count).to eql(1)
          expect(flash[:danger]).to eql(I18n.t('password_reset.expired'))
        end
      end
    end

    context 'User is not found' do
      before { allow(User).to receive(:find_by).with(anything).and_return(nil) }

      it 'Return user not exist' do
        subject
        expect(flash.count).to eql(1)
        expect(flash[:danger]).to eql(I18n.t('users.not_exist'))
      end

      it 'Redirect to new password reset' do
        expect(subject).to redirect_to(root_path)
      end
    end
  end
end
