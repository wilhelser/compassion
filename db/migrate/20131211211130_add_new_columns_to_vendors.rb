class AddNewColumnsToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :due_date, :date
    add_column :vendors, :account_no, :string
    add_column :vendors, :paid, :boolean, :default => false
  end
end
