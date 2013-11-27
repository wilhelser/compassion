class ChangePrecisionScaleOnVendorAmounts < ActiveRecord::Migration
  def change
    change_column :vendors, :amount, :decimal, :scale => 2, :precision => 8
  end
end
