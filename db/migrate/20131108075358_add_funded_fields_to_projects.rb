class AddFundedFieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :funded, :boolean, :default => false
    add_column :projects, :funded_date, :date
  end
end
