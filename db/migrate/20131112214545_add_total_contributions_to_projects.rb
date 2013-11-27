class AddTotalContributionsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :total_contributions, :decimal, :scale => 2, :precision => 8, :default => 0.00
  end
end
