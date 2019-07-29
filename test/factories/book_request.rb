FactoryBot.define do
  factory :book_request do
    name { Faker::Book.title }
    budget { rand(10..100) }
    quantity { rand(1..100) }
    comment { Faker::Lorem.sentence }
    user
  end
end
