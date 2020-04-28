FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph_by_chars }
    association :user

    after(:create) do |article|
      commenter = FactoryBot.create(:user)
      FactoryBot.create_list(:comment, 50, article: article, user: commenter)
    end
  end
end
