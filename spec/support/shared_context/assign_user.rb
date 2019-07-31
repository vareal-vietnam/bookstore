RSpec.shared_context 'assign user' do
  let(:image_files) do
    Rack::Test::UploadedFile.new(
      Rails.root.join('spec/support/default-book-cover.jpg'), 'image/jpeg'
    )
  end
  let(:other_user) { create(:user) }
  let(:valid_user_params) do
    user_params = attributes_for(:user)
    {
      name: user_params[:name],
      address: user_params[:address],
      password: user_params[:password],
      password_confirmation: user_params[:password_confirmation],
      avatar: image_files
    }
  end

  let(:invalid_user_params) { { name: nil } }
end
