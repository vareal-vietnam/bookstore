DEFAULT_PASSWORD = 'Aa123456'.freeze
DEFAULT_PHONE_NUMBER = '0123456789'.freeze

def generate_image_url width,height
  image_id = rand(60..70)
  "https://picsum.photos/id/#{image_id}/#{width}/#{height}"
end

def generate_phone_number
  "0" + rand(100000000..899999999).to_s
end

User.create!(
    name: 'Admin',
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD,
    address: Faker::Address.city,
    phone: DEFAULT_PHONE_NUMBER,
    remote_avatar_url: generate_image_url(600, 600)
  )

5.times do
  user = User.create!(
    name: Faker::Name.first_name,
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD,
    address: Faker::Address.city,
    phone: generate_phone_number,
    remote_avatar_url: generate_image_url(600, 600)
  )
  5.times do
    book = Book.create!(
      name: Faker::Book.title,
      price: rand(10..999),
      quantity: rand(1..20),
      comment: Faker::Lorem.paragraph(10),
      description: Faker::Lorem.paragraph(50),
      user_id: user.id
    )
    2.times do
      book.images.create!(remote_file_url: generate_image_url(600, 900))
    end
  end
  5.times do
    book_request = BookRequest.create!(
      name: Faker::Book.title,
      budget: rand(0..100),
      quantity: rand(1..10),
      comment: Faker::Lorem.paragraph(10),
      user_id: user.id
    )
    2.times do
      book_request.book_request_images.create!(remote_file_url: generate_image_url(600, 900))
    end
  end
end
