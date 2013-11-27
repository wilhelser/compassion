class AddBackerCountToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :backer_count, :integer, :default => 0
  end
end
