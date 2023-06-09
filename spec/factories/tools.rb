FactoryBot.define do
  factory :tool do
    store_name { 'store' }
    total_unit { '100' }
    user
    after(:build) do |tool|
      tool.tool_units << build_list(:tool_unit, 20, tool:)
    end
  end

  trait :created_yesterday do
    created_at { Time.current.yesterday }
  end
end
