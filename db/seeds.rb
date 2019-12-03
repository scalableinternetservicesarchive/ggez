# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create CS user for general load testing

example_cs_user = User.create!(
  username: 'sample_user_cs',
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
  username: 'sample_user_finance',
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



count = 100_000
review_count = 20

user_sql = 'INSERT INTO users '\
      '(username, industry, password_digest, points, created_at, updated_at)'\
      ' VALUES '
resume_sql = 'INSERT INTO resumes '\
             '(file, user_id, created_at, updated_at, public)'\
             ' VALUES '

review_sql = 'INSERT INTO reviews '\
             '(rating, content, user_id, resume_id, created_at, updated_at)'\
             ' VALUES '


(1..count).each do |n|
  delim = n == count - 1 ? ';' : ','

  user_sql << "('sample_user_finance_#{n}', 'finance', 'fake_digest', 5, 0, 0)" << delim

  resume_sql << "('dummy.pdf', #{n}, 0, 0, 1)" << delim

  contents = ['I like this resume. Good work!',
              'This resume is perfect!!!',
              'Bad resume.',
              'Needs some work']
  ratings = (0...5).to_a

  5.times do
    review_sql << "(#{ratings.sample}, '#{contents.sample}', #{n}, #{n}, 0, 0),"
  end
  review_sql << "(#{ratings.sample}, '#{contents.sample}', #{n}, #{n}, 0, 0)" << delim
end


ActiveRecord::Base.connection.execute(user_sql)
ActiveRecord::Base.connection.execute(resume_sql)
ActiveRecord::Base.connection.execute(review_sql)