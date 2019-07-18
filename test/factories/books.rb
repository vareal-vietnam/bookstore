FactoryBot.define do
  factory :book do
    name { Faker::Book.title }
    price { rand(10..100) }
    quantity { rand(1..100) }
    description { 'Faker::Lorem.sentence' }

    user
  end
end
