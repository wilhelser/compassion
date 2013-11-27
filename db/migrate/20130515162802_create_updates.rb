class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.integer :project_id, :null => false
      t.text :body, :null => false
      t.boolean :facebook, :default => false
      t.boolean :twitter, :default => false
      t.boolean :email, :default => false

      t.timestamps
    end
  end
end
