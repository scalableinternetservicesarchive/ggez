class AddPublicityToResumes < ActiveRecord::Migration[6.0]
  def change
    add_column :resumes, :public, :boolean, default: false
  end
end
