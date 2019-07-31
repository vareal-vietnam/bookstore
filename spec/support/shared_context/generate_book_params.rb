RSpec.shared_context 'generate book_params' do
  let(:image_files) do
    image_files = []
    rand(1..3).times do
      image_files << Rack::Test::UploadedFile.new(
        Rails.root.join('spec/support/default-book-cover.jpg'),
        'image/jpeg'
      )
    end
    image_files
  end

  let(:book_params) { attributes_for(:book) }

  let(:valid_book_params) do
    {
      name: book_params[:name],
      price: book_params[:price],
      description: book_params[:description],
      quantity: book_params[:quantity],
      comment: book_params[:comment],
      files: image_files
    }
  end

  let(:valid_book_params_without_images) do
    {
      name: book_params[:name],
      price: book_params[:price],
      description: book_params[:description],
      quantity: book_params[:quantity],
      comment: book_params[:comment],
      files: []
    }
  end

  let(:invalid_book_params) { { name: nil } }
end
