FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph_by_chars }
    association :article
    # comment facotoryは現在 作成できませんが後日対応します
  end
end
