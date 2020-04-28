FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph_by_chars }
    association :user

    trait :with_comments do
      transient do
        comments_length { 2 }
      end

      after(:create) do |article, evaluator|
        FactoryBot.create_list(:comment, evaluator.comments_length, article: article)
      end
    end
  end
end
