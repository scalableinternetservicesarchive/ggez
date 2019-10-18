class Resume < ApplicationRecord
  mount_uploader :file, FileUploader
  validates :file, presence: true
  validates :user_id, uniqueness: true
  belongs_to :user
end
