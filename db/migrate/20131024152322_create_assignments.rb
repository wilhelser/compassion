class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :project_id, :null => false
      t.integer :adjuster_id, :null => false

      t.timestamps
    end
  end
end
