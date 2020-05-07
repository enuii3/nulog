FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph_by_chars }
    association :article
    commenter_name { guest_name }

    transient do
      guest_name { Faker::Games::Pokemon.name }
    end

    trait :with_user do
      association :user
      commenter_name { user.name }
    end
  end
end
