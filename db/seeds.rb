user = User.create!(
  name: "Mr Dinh",
  password: "123456",
  password_confirmation: "123456",
  address: "Ha Noi",
  phone: "0963482125",
  avatar: "https://lumiere-a.akamaihd.net/v1/images/file_6fa4374d.jpeg?width=1200&region=0%2C0%2C2000%2C2000"
)

40.times do |f|
  book = Book.create!(
    name: Faker::Book.title,
    price: Random.rand(1..99),
    quantity: Random.rand(1..99),
    description: Faker::Lorem.sentence,
    user_id: user.id
  )
  3.times do
    id = rand(1..100)
    Image.create!(
      url: "https://picsum.photos/id/#{id}/600/900",
      book_id: book.id
    )
  end
end
