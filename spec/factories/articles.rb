FactoryBot.define do
  factory :article do
    title { "はじめまして、コンチにちは、おはようございます。おやすみなさい、こんばんわ、ありがとうございます！！" * 4 }
    body  { "Nice to meet you, thank you very much, good morning, good afternoon, good evening, good night every1" * 20 }
    association :user
  end
end