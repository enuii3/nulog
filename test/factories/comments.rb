FactoryBot.define do
  factory :comment do
    body { Faker::Books::Lovecraft }
    association :article
    # comment facotoryは現在 作成できませんが後日対応します
  end
end
