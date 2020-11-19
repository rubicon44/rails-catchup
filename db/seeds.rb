# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者ユーザー作成
admin = User.create!(
  username:  "管理者",
  email: "admin@admin.com",
  password:  "adminadmin",
  admin: true
)
admin.avatar = open("#{Rails.root}/db/fixtures/admin.jpg")
admin.save

# テストユーザー作成
user = User.create!(
   username: 'testtest',
   email: 'test@test.com',
   password: 'testtest'
)
user.avatar = open("#{Rails.root}/db/fixtures/avatar-1.jpg")
user.save