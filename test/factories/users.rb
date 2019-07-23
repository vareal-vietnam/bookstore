FactoryBot.define do
  factory :user do
    password_temple = Random.rand(100_000..999_999).to_s
    name { Faker::Name.first_name }
    address { Faker::Address.city }
    password { password_temple }
    password_confirmation { password_temple }
    phone { '0' + Random.rand(100_000_000..999_999_999).to_s }
  end
end
