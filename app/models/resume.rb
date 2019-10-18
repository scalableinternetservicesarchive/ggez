class Resume < ApplicationRecord
  mount_uploader :file_content, FileContentUploader
  validates :file_content, presence: true
  belongs_to :user
end
