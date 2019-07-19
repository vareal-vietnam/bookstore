DEFAULT_PASSWORD = 'Aa123456'.freeze
DEFAULT_PHONE_NUMBER = '0123456789'.freeze

def generate_image_url(width,height)
  image_id = rand(1..900)
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
    avatar: generate_image_url(600,600)
  )

10.times do
  user = User.create!(
    name: Faker::Name.first_name,
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD,
    address: Faker::Address.city,
    phone: generate_phone_number,
    avatar: generate_image_url(600,600)
  )
  5.times do
    book = Book.create!(
      name: Faker::Book.title,
      price: rand(10..999),
      quantity: rand(1..20),
      description: Faker::Lorem.sentence,
      user_id: user.id
    )
    3.times do
      Image.create!(
        url: generate_image_url(600,900),
        book_id: book.id
      )
    end
  end
end
