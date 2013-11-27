class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.integer :project_id, :null => false
      t.string :name, :null => false, :limit => 100
      t.decimal :amount, :null => false, :precision => 5, :scale => 2
      t.string :contact_name, :limit => 100
      t.string :address, :limit => 100
      t.string :city, :limit => 80
      t.string :state, :limit => 2
      t.integer :zip_code, :limit => 10
      t.string :phone, :limit => 20
      t.string :invoice_number, :limit => 100
      t.text :description, :limit => 100
      t.string :documentation
      t.boolean :verified, :default => false

      t.timestamps
    end
  end
end
