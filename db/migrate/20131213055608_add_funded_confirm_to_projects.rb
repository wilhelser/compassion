class AddFundedConfirmToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :funded_confirm, :boolean, :default => false
  end
end
