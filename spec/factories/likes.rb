FactoryBot.define do
  factory :like do
    association :user
    association :goal
  end
end