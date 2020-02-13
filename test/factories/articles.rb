FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    body { Faker::Books::Lovecraft.paragraph }
    association :user
  end
end
