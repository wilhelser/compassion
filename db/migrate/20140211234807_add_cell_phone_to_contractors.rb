class AddCellPhoneToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :cell_phone, :string, limit: 30
  end
end
