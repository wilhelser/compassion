class AddNotifyOnAssignmentToAdjusters < ActiveRecord::Migration
  def change
    add_column :adjusters, :notify_on_assignment, :boolean, default: true
  end
end
