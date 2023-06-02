FactoryBot.define do
  factory :tool do
    sequence(:store_name) { |n| "store_#{n}" }
    total_unit { Faker::Number.between(from: 10, to: 5000) }
    trait :with_nested_instances do
      after(:create) do |tool|
        create(:tool_unit, id: tool.id)
      end
    end
    association :user
  end
end
