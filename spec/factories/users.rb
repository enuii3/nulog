FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "sample#{n}@nulog.com" }
    password { 'hogehoge' }
    password_confirmation { 'hogehoge' }

    trait :with_location do
      prefecture_name { '東京都' }
      city_name { '東京' }
    end
  end
end
