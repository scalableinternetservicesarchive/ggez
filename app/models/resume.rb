class Resume < ApplicationRecord
  mount_uploader :file_content, FileContentUploader
  validates :file_content, presence: true
  validates :user_id, uniqueness: true
  belongs_to :user
end
