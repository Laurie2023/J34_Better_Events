# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

Attendance.destroy_all
User.destroy_all
Event.destroy_all

5.times do 
  user = User.create!(
    email:Faker::Internet.email(domain: 'yopmail.com'),
    description:Faker::Hipster.paragraph, 
    first_name:Faker::Name.first_name,
    last_name:Faker::Name.first_name,
    password:Faker::Lorem.characters(number: 10),
    )
end
current_users_id = User.ids

10.times do 
  event = Event.create!(
    start_date:Faker::Date.in_date_period, duration:rand(15..500), 
    title:Faker::Marketing.buzzwords, 
    description:Faker::Quote.famous_last_words, 
    price:rand(15..150), 
    location:Faker::Address.city, 
    admin:User.find(rand((User.first.id)..(User.last.id))))
end 
current_events_id = Event.ids

2.times do 
  attend = Attendance.create!(
    stripe_customer_id:Faker::Code.nric,
    user_id:current_users_id.sample,
    event_id:current_events_id.sample)
end 