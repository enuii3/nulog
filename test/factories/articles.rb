FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    body { Faker::Books::Lovecraft }
    association :user
  end
end
