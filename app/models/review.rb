class Review < ApplicationRecord
  belongs_to :user
  belongs_to :resume
  validates :rating, inclusion: 0..5
  validates :content, presence: true
end
