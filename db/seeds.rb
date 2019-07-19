User.create!(
    name: 'Admin',
    password: "123456",
    password_confirmation: "123456",
    address: Faker::Address.city,
    phone: '0963482125',
    avatar: "https://i.pravatar.cc/1000"
  )

10.times do
  user = User.create!(
    name: Faker::Name.first_name,
    password: "123456",
    password_confirmation: "123456",
    address: Faker::Address.city,
    phone: "0" + Random.rand(100000000..899999999).to_s,
    avatar: "https://i.pravatar.cc/1000"
  )
  5.times do
    book = Book.create!(
      name: Faker::Book.title,
      price: Random.rand(10..999),
      quantity: Random.rand(1..20),
      description: Faker::Lorem.sentence,
      user_id: user.id
    )
    3.times do
      id = rand(1..900)
      Image.create!(
        url: "https://picsum.photos/id/#{id}/600/900",
        book_id: book.id
      )
    end
  end
end
