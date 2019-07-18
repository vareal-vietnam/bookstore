FactoryBot.define do
  factory :user do
    name { 'Cuong' }
    address { 'ha Noi' }
    password { 'Not null' }
    password_confirmation { 'Not null' }
    phone { '0963482125' }
    avatar { 'avatar.com/dinh' }
  end
end
