FactoryBot.define do
  factory :user do
    name { 'foobar' }
    email { 'sample@hogehoge.com' }
    encrypted_password { 'hogehoge' }
  end

  factory :other, class: User do
    name { 'mickel hartle' }
    email { 'foobar@hogehoge.com' }
    encrypted_password { 'hogehoge' }
  end
end
