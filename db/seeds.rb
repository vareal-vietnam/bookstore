99.times do |n|
  name  = Faker::Name.name
  price = 50
  quantity = 50
  Book.create!(name:  name,
               price: price,
               quantity: quantity)
end
