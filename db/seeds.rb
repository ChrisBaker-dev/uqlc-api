# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
User.create(email: "d@g.com", password:"hello")

User.create(email: "ch@ris.com", password:"hello", admin: "true")

user = User.find_by_email("d@g.com")

Post.destroy_all
Post.create(user: user, title:"Training", description: "Tonight @ 8pm on Field 9")

Player.destroy_all

Player.create(user: user, name: "Chris", position: "Defense", number: "4", seasons: "12", description: "I like lacrosse, its so much fun")