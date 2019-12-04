# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

count = 100_000
review_count = 8

user_sql = 'INSERT INTO users '\
           '(username, industry, password_digest, points, created_at, updated_at)'\
           ' VALUES '
resume_sql = 'INSERT INTO resumes '\
             '(file, user_id, created_at, updated_at, public)'\
             ' VALUES '
review_sql = 'INSERT INTO reviews '\
             '(rating, content, user_id, resume_id, created_at, updated_at)'\
             ' VALUES '

contents = ['I like this resume. Good work!',
            'This resume is perfect!!!',
            'Bad resume.',
            'Needs some work']
ratings = (0...5).to_a
ids = (1..(count - 1)).to_a

(1..count).each do |n|
  delim = n == count - 1 ? ';' : ','

  user_sql << "('sample_user_cs_#{n}', 'CS', 'fake_digest', 5, 0, 0)" << delim

  resume_sql << "('dummy.pdf', #{n}, 0, 0, 1)" << delim

  (review_count - 1).times do
    review_sql << "(#{ratings.sample}, '#{contents.sample}', #{ids.sample}, #{n}, 0, 0),"
  end
  review_sql << "(#{ratings.sample}, '#{contents.sample}', #{ids.sample}, #{n}, 0, 0)" << delim
end


ActiveRecord::Base.connection.execute(user_sql)
ActiveRecord::Base.connection.execute(resume_sql)
ActiveRecord::Base.connection.execute(review_sql)