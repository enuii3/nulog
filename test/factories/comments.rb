FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph_by_chars }
    association :article
    # TODO: 現状作成できないのでモデル側を含め、後日対応
  end
end
