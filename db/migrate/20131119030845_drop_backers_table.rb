class DropBackersTable < ActiveRecord::Migration
  def change
    drop_table :backers
  end
end
