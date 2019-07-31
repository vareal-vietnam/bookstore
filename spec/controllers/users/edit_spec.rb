require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include_context 'logged in'
  include_context 'assign user'

  describe '#edit' do
    context 'with same user' do
      before { get :edit, params: { id: current_user.id } }

      it 'expect has no flash message' do
        expect(flash.count).to equal(0)
      end
    end

    context 'with different user' do
      before { get :edit, params: { id: other_user.id } }

      it 'gets danger flash message' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end

      it 'should be redirect to home' do
        expect(subject).to redirect_to(root_url)
      end
    end
  end
end
