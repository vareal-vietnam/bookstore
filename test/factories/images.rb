FactoryBot.define do
  factory :image do
    file { Rack::Test::UploadedFile.new(
      Rails.root.join('spec/support/default-book-cover.jpg'),
      'image/jpeg'
    ) }
    book
  end
end
