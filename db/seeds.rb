# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def random_future_date
  rand(1..365).days.from_now
end

movies_data = [
  {
    title: Faker::Movie.title,
    release_date: random_future_date,
    description: "ioj",
    created_at: Time.now - rand(1..30).days,
    updated_at: Time.now - rand(1..30).days,
    poster_url: "https://images.pexels.com/photos/2873486/pexels-photo-2873486.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    trailer_url: nil
  },
 
  # Add more movie data as needed
  # { ... },
  # { ... },
  # { ... }
]
admin_user = User.create(
  email: 'john@example.com',
  password: '12344567'
)

user =User.create(
  email: 'jane@example.com',
  password: '1234567'
)
admin_role = Role.create(role_type: "admin")
user_role  = Role.create(role_type: "user")
admin_user.role << admin_role
user.role << user_role

# Create 15 movie objects
15.times do |index|
  Movie.create!(movies_data[0])
end
