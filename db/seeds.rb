# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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

1.upto(99) do |n|
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