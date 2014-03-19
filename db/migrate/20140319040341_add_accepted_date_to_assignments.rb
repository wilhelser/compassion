class AddAcceptedDateToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :date_accepted, :date
  end
end
