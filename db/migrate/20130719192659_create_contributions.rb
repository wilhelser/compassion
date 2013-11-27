class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.integer :project_id, :null => false
      t.integer :backer_id, :null => false
      t.decimal :amount, :precision => 5, :scale => 2, :default => 0.00, :null => false

      t.timestamps
    end
  end
end
