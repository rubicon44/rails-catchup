FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "sample#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { '123456' }
    profile { 'はじめまして！' }

    trait :invalid do
      username { 'users' } # 既存のルーティング("/users")と重複するユーザーネーム
      email    { 'user@invalid' }
      password { 'bar' }
    end

    trait :guest do
      username { 'guest' }
      email    { 'guest@example.com' }
      password { '123456' }
      guest    { true }
    end

    trait :admin do
      username { 'admin' }
      email    { 'admin@example.com' }
      password { '123456' }
      admin    { true }
    end

    trait :with_goals do
      transient do
        goals_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:goal, evaluator.goals_count, user: user)
      end
    end
  end
end