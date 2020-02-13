FactoryBot.define do
  factory :comment do
    body { Faker::Books::Lovecraft }
    association :article
  end
end
