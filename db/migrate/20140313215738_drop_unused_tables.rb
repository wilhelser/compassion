class DropUnusedTables < ActiveRecord::Migration
  def change
    drop_table :addresses
    drop_table :references
  end
end
