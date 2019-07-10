99.times do
  Book.create!(
    name: Faker::Name.name,
    price: Random.rand(1..99),
    quantity: Random.rand(1..99)
  )
end
