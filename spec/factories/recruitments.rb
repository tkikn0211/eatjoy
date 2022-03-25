FactoryBot.define do
  factory :recruitment do
    title { Faker::Lorem.characters(number:15) }
    body { Faker::Lorem.characters(number:100) }
    store_name { "テストステーキ" }
    store_address { "東京都新宿区西新宿" }
    genre { "ステーキ" }
    user
  end
end
