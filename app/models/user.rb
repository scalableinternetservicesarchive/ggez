class User < ApplicationRecord
  before_save { self.username = self.username.downcase }
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false }
  validates :industry, presence: true

  has_secure_password
end
