FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    address { Faker::Address.city }
    password { 'Not null' }
    password_confirmation { 'Not null' }
    phone { '0' + Random.rand(100_000_000..999_999_999).to_s }
    avatar { 'https://i.pravatar.cc/1000' }
  end
end
