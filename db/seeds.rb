# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

example_user = User.create!(
    username: 'example', industry: 'CS',
    password: 'a', password_confirmation: 'a',
    points: 1_000_000_000
)

example_resume = Resume.create!(
    user_id: example_user.id,
    public: true,
    file: Rails.root.join("app/assets/images/dummy.pdf").open
)