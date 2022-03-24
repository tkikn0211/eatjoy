FactoryBot.define do
  factory :recruitment do
    title { Faker::Lorem.characters(number:20) }
    body { Faker::Lorem.characters(number:100) }
  end
end
