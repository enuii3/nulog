FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph_by_chars }
    association :article
  end
end
