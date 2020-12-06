FactoryBot.define do
  factory :notification do
    visitor_id { 1 }
    visited_id { 1 }

    association :goal
    association :comment
  end
end