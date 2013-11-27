class RemoveTotalContributionsColumnFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :total_contributions
  end
end
