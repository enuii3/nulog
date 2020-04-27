FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph_by_chars }
    association :user

    after(:create) do |article|
      FactoryBot.create_list(:comment, 3, article: article)
    end
  end
end
