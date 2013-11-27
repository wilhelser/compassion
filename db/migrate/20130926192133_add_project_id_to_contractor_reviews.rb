class AddProjectIdToContractorReviews < ActiveRecord::Migration
  def change
    add_column :contractor_reviews, :project_id, :integer, :null => false
  end
end
