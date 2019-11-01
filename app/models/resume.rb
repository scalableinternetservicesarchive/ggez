class Resume < ApplicationRecord
  mount_uploader :file, FileUploader
  validates :file, presence: true
  belongs_to :user
  has_many :reviews, dependent: :destroy
  
  after_destroy :destroy_assets
  
  def destroy_assets
    file&.remove!
  end
end
