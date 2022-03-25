FactoryBot.define do
  factory :user do
    last_name { "テスト" }
    first_name { "テスト" }
    last_name_kana { "テスト" }
    first_name_kana { "テスト" }
    account_name { "test" }
    address { "東京都" }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
  end
end