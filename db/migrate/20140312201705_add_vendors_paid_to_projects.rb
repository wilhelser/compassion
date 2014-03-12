class AddVendorsPaidToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :vendors_paid, :boolean, default: false
  end
end
