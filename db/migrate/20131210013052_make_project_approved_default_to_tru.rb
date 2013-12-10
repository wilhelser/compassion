class MakeProjectApprovedDefaultToTru < ActiveRecord::Migration
  def change
    change_column :projects, :approved, :boolean, :default => true
  end
end
