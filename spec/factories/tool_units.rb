FactoryBot.define do
  factory :tool_unit do
    sequence(:number, &:to_s)
    medal { '1000' }
    tool
  end
end
