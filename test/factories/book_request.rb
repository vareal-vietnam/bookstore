FactoryBot.define do
  factory :book_request do
    name { Faker::Book.title }
    budget { rand(0..100_000) }
    quantity { rand(1..10) }
    comment { Faker::Lorem.sentence }

    user
  end
end
