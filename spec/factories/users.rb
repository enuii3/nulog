FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "sample#{n}@nulog.com" }
    password { 'hogehoge' }
    password_confirmation { 'hogehoge' }
  end
end
