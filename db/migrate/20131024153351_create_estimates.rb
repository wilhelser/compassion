class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.integer :project_id, :null => false
      t.integer :adjuster_id, :null => false
      t.decimal :amount, :scale => 2, :precision => 8, :default => 0.00, :null => false
      t.text :description
      t.string :document, :null => false

      t.timestamps
    end
  end
end
