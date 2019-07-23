require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:current_user) { create(:user) }

  before do
    allow(User).to receive(:find_by).with(anything).and_return(current_user)
  end

  describe '#edit' do
    context 'with current_user.id' do
      before do
        get 'edit', params: { id: current_user.id }
      end

      it 'flash[:danger] is nil' do
        expect(flash[:danger]).to equal(nil)
      end
    end

    context 'with different current_user.id' do
      before do
        guest = create(:user)
        get 'edit', params: { id: guest.id }
      end

      it 'flash[:danger] should be "Page not found"' do
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end

      it 'should be redirect to home' do
        expect(subject).to redirect_to(root_url)
      end
    end
  end

  describe '#update' do
    context 'with validate user_params' do
      before do
        validate_user = create(:user)
        put 'update', params: {
          id: current_user.id,
          user: {
            name: validate_user.name,
            address: validate_user.address,
            password: validate_user.password,
            password_confirmation: validate_user.password_confirmation,
            avatar: validate_user.avatar
          }
        }
      end

      it 'flash[:succsess] should be "Data have updated"' do
        expect(flash[:success]).to eql(I18n.t('users.update.update_success'))
      end

      it 'should be redirect to current_user' do
        expect(subject).to redirect_to(current_user)
      end
    end

    context 'with invalidate user_params' do
      before do
        put 'update', params: {
          id: current_user.id,
          user: {
            name: nil,
            address: nil,
            password: nil,
            password_confirmation: nil,
            avatar: nil
          }
        }
      end

      it 'should be render to edit' do
        expect(subject).to render_template(:edit)
      end
    end
  end
end

