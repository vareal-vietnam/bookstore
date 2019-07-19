default_password = "123456".freeze

def generate_image_url
  id = rand(1..900)
  "https://picsum.photos/id/#{id}/600/900"
end

def generate_avatar_url
  id = rand(1..900)
  "https://picsum.photos/id/#{id}/600/600"
end

def generate_phone_number
  "0" + rand(100000000..899999999).to_s
end

User.create!(
    name: 'Admin',
    password: "default_password",
    password_confirmation: "default_password",
    address: Faker::Address.city,
    phone: '0123456789',
    avatar: generate_avatar_url
  )

10.times do
  user = User.create!(
    name: Faker::Name.first_name,
    password: "default_password",
    password_confirmation: "default_password",
    address: Faker::Address.city,
    phone: generate_phone_number,
    avatar: generate_avatar_url
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
        url: generate_image_url,
        book_id: book.id
      )
    end
  end
end
