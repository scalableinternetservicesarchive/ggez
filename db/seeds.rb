# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create CS user for general load testing

example_cs_user = User.create!(
  username: 'example',
  industry: 'CS',
  password: 'a',
  password_confirmation: 'a',
  points: 1_000_000_000
)

Resume.create!(
  user: example_cs_user,
  public: true,
  file: Rails.root.join('app/assets/images/dummy.pdf').open
)

# Create a Finance user which will have lots of reviews

example_finance_user = User.create!(
  username: 'example',
  industry: 'finance',
  password: 'a',
  password_confirmation: 'a',
  points: 1_000_000_000
)

example_finance_resume = Resume.create!(
  user: example_finance_user,
  public: true,
  file: Rails.root.join('app/assets/images/dummy.pdf').open
)

# Create lots more users and reviews
100.times do |n|
  new_user = User.create!(
    username: "sample_user_#{n}",
    industry: 'finance',
    password: 'a',
    password_confirmation: 'a',
    points: 5
  )
  comments = ['I like this resume. Good work!',
              'This resume is perfect!!!',
              'Bad resume.',
              'Needs some work']
  Review.create!(
    rating: rand(0..5),
    content: comments.sample,
    user: new_user,
    resume: example_finance_resume
  )
end