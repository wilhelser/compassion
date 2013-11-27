class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :user_id, :nil => false
      t.decimal :goal_amount, :nil => false
      t.string :page_title, :limit => 40, :null => false
      t.integer :zip_code, :limit => 5, :null => false
      t.text :page_message, :null => false
      t.string :slug
      t.boolean :approved, :null => false, :default => false

      t.timestamps
    end
  end
end
