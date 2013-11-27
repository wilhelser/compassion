class AddApprovedToAdjusters < ActiveRecord::Migration
  def change
    add_column :adjusters, :approved, :boolean, :default => false
  end
end
