# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Faker::Config.locale = :en

# ゲストユーザー作成
User.create!(
             username: 'guest',
             email: 'guest@example.com',
             password: '123456',
             password_confirmation: '123456',
             confirmed_at: Time.zone.now,
             confirmation_sent_at: Time.zone.now,
             guest: true
)

1.upto(10) do |n|
  username = "sample#{n}"
  email = "sample-#{n}@example.com"
  password = "123456"

  User.create!(
               username: username,
               email: email,
               password:              password,
               password_confirmation: password,
               confirmed_at: Time.zone.now,
               confirmation_sent_at: Time.zone.now
  )
end

users = User.order(:created_at).take(9)

users.each_with_index do |user, n|
  user.avatar = open("#{Rails.root}/db/fixtures/avatar-#{n}.jpg")
  user.save
end

# 管理者ユーザー作成
admin = User.create!(
  username:  "admin",
  email: "admin@admin.com",
  password:  "adminadmin",
  password_confirmation: 'adminadmin',
  confirmed_at: Time.zone.now,
  confirmation_sent_at: Time.zone.now,
  admin: true
)
admin.avatar = open("#{Rails.root}/db/fixtures/admin.jpg")
admin.save

# タスク登録
1.upto(1) do |n|
  users[1].goals.create!(
    name: "Railsを極める",
    description: "Railsを極める",
    status: 2,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  )

  users[1].goals.create!(
    name: "Web系自社開発企業に転職する",
    description: "Web系自社開発企業に転職する",
    status: 1,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  )

  users[1].goals.create!(
    name: "フリーランスになる",
    description: "フリーランスになる",
    status: 0,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  )
end

1.upto(1) do |n|
  users[2].goals.create!(
    name: "Reactを極める",
    description: "Reactを極める",
    status: 3,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  )

  users[2].goals.create!(
    name: "受託制作企業に転職する",
    description: "受託制作企業に転職する",
    status: 2,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  )

  users[2].goals.create!(
    name: "Webディレクターになる",
    description: "Webディレクターになる",
    status: 1,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  )
end


1.upto(1) do |n|
  name = "HTMLを極める"
  description = "HTMLを極める"
  status = 2

  users[3].goals.create!(
    name: name,
    description: description,
    status: status,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  )
end


1.upto(1) do |n|
  name = "CSSを極める"
  description = "CSSを極める"
  status = 3

  users[4].goals.create!(
    name: name,
    description: description,
    status: status,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  )
end


1.upto(1) do |n|
  name = "AWSを極める"
  description = "AWSを極める"
  status = 0

  users[5].goals.create!(
    name: name,
    description: description,
    status: status,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  )
end

1.upto(1) do |n|
  name = "GCPを極める"
  description = "GCPを極める"
  status = 1

  users[6].goals.create!(
    name: name,
    description: description,
    status: status,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  )
end

1.upto(1) do |n|
  name = "Firebaseを極める"
  description = "Firebaseを極める"
  status = 2

  users[7].goals.create!(
    name: name,
    description: description,
    status: status,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  )
end

1.upto(1) do |n|
  name = "GatsbyJSを極める"
  description = "GatsbyJSを極める"
  status = 3

  users[8].goals.create!(
    name: name,
    description: description,
    status: status,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  )
end

# いいね

# コメント

# リレーションシップ