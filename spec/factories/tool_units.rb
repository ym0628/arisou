FactoryBot.define do
  factory :tool_unit do
    sequence(:number) { Faker::Number.between(to: 5000) }
    medal { Faker::Number.between(from: -30_000, to: 30_000) }
  end
end
