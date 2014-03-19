class AddAcceptedToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :accepted, :boolean, default: false
  end
end
