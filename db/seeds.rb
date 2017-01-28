# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(email: Faker::Internet.email, password: 12345678)
user2 = User.create!(email: Faker::Internet.email, password: 12345678)

5.times do 
  Event.create!(title: Faker::Pokemon.name, body: Faker::Lorem.sentence, start_date: Faker::Date.between(2.days.ago, Date.today), end_date: Faker::Date.forward(60))
end

Event.all.each do |event|
  8.times do
    fake_event_post = event.posts.create!(title: Faker::Cat.name, body: Faker::Cat.breed, user_id: user.id)
      4.times do 
        fake_event_post.comments.create!(body: Faker::Cat.registry, user_id: user2.id)
      end
  end
end
