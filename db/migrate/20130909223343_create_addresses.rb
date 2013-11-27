class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :contractor_id, :null => false
      t.string :address
      t.string :addres2
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :address_type

      t.timestamps
    end
  end
end
