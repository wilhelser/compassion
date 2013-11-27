class ChangeAdjustersAddressToStreetAddress < ActiveRecord::Migration
  def change
    rename_column :adjusters, :address, :street_address
  end
end
