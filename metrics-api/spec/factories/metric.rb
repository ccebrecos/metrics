FactoryBot.define do
  factory :metric do
    name { Faker::Lorem.characters(number: 6) }
    value { Faker::Number.decimal }
    valid_at { Time.now }
  end
end
