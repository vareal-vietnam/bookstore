FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    address { Faker::Address.city }
    password { "Not null" }
    password_confirmation { "Not null" }
    phone { "0963482125" }
    avatar { "avatar.com/dinh" }
  end
end
