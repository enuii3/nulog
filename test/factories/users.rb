FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "sample#{n}@nulog.com" }
    encrypted_password { 'hogehoge:' }
  end
end
