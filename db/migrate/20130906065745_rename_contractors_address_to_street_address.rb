class RenameContractorsAddressToStreetAddress < ActiveRecord::Migration
  def change
    rename_column :contractors, :address, :street_address
  end
end
