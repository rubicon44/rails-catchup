FactoryBot.define do
  factory :user do
    name { "TestUser" }
    nickname { "TestNickName" }
    sequence(:email) { |n| "Test#{n}@example.com" }
    profile_message { "はじめまして！" }
    created_at { "2020年11月16日" }
  end
end