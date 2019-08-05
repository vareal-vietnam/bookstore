RSpec.shared_context 'user_login_params' do
  let(:password) { 'Aa123456' }
  let(:other_password) { 'Aa00000' }
  let(:user) do
    create(:user, password: password, password_confirmation: password)
  end

  let(:valid_user_params) do
    {
      phone: user.phone,
      password: password
    }
  end

  let(:invalid_user_params) do
    {
      phone: user.phone,
      password: other_password
    }
  end

  let(:valid_user_params_checked_remember_me) do
    {
      phone: user.phone,
      password: password,
      remember_me: '1'
    }
  end

  let(:valid_user_params_unchecked_remember_me) do
    {
      phone: user.phone,
      password: password,
      remember_me: '0'
    }
  end
end
