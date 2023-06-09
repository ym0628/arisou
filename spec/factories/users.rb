FactoryBot.define do
  factory :user do
    sequence(:id, &:to_s)
    sequence(:first_name) { |n| "user_#{n}" }
    sequence(:last_name) { |n| "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password              { "password" }
    password_confirmation { "password" }
  end
end
