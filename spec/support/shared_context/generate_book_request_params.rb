RSpec.shared_context 'generate book_request_params' do
  let(:book_request_params) { attributes_for(:book_request) }

  let(:image_files) do
    image_files = []
    rand(1..5).times do
      image_files << Rack::Test::UploadedFile.new(
        Rails.root.join('spec/support/default-book-cover.jpg'),
        'image/jpeg'
      )
    end
    image_files
  end

  let(:valid_book_request_params) do
    {
      name: book_request_params[:name],
      budget: book_request_params[:budget],
      quantity: book_request_params[:quantity],
      comment: book_request_params[:comment],
      book_request_images: image_files
    }
  end

  let(:invalid_book_request_params) { { name: nil } }
end
