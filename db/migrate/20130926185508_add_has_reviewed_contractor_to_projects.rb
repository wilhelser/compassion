class AddHasReviewedContractorToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :has_reviewed_contractor, :boolean, :default => false
  end
end
