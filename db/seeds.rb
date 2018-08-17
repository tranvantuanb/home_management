# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user_admin = User.create email: "tuan_admin@gmail.com", password: "123123", name: "Tuan Admin",
  address: "Ha Noi", role: :admin, phone_number: "0973322413"
