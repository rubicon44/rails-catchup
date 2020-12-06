FactoryBot.define do
  factory :goal do
    sequence(:user_id) { |n| "#{n}" }
    name { "Test Title" }
    description { "Test Description" }

    association :user

    trait :with_comments do
      transient do
        comments_count { 5 }
      end

      after(:create) do |goal, evaluator|
        create_list(:comment, evaluator.comments_count, goal: goal)
      end
    end

    trait :with_likes do
      transient do
        likes_count { 5 }
      end

      after(:create) do |goal, evaluator|
        create_list(:like, evaluator.likes_count, goal: goal)
      end
    end
  end
end