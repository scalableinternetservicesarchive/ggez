class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :industry, presence: true
  has_many :resumes, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_secure_password
end
