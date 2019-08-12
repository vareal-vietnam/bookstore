FactoryBot.define do
  factory :image do
    file do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec/support/default-book-cover.jpg'), 'image/jpeg'
      )
    end
    book
  end
end
