FactoryBot.define do
  factory :book_request_image do
    file do
      Rack::Test::UploadedFile
        .new(File.join(Rails.root, 'spec/support/default-book-cover.jpg'))
    end
    book_request
  end
end
