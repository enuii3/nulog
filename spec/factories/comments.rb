FactoryBot.define do
  factory :comment do
    body { "1yreve thgin doog ,gnineve doog ,noonretfa doog ,gninrom doog ,hcum yrev uoy knaht ,uoy teem ot eciN" * 5 }
    association :user
  end
end