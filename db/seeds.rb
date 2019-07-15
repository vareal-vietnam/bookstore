40.times do |f|
  book = Book.create!(
    name: Faker::Name.name,
    price: Random.rand(1..99),
    quantity: Random.rand(1..99)
  )
  3.times do
    id = rand(1..100)
    Image.create!(
      url: "https://picsum.photos/id/#{id}/600/900",
      book_id: book.id
    )
  end
end
