# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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

# ゲストユーザー作成
guest = User.create!(
  username: 'guest',
  email: 'guest@example.com',
  password: '123456',
  password_confirmation: '123456',
  confirmed_at: Time.zone.now,
  confirmation_sent_at: Time.zone.now,
  guest: true
)
guest.avatar = open("#{Rails.root}/db/fixtures/avatar-0.jpg")
guest.save

# テストユーザー作成
user = User.create!(
   username: 'testtest',
   email: 'test@test.com',
   password: 'testtest',
   password_confirmation: 'testtest',
   confirmed_at: Time.zone.now,
   confirmation_sent_at: Time.zone.now
)
user.avatar = open("#{Rails.root}/db/fixtures/avatar-1.jpg")
user.save