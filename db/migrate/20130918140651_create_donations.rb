class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.decimal :amount, :nil => false, :precision => 8, :scale => 2
      t.string :name, :limit => 100
      t.integer :zip_code, :limit => 5
      t.text :comments
      t.string :city, :limit => 60
      t.string :state, :limit => 2

      t.timestamps
    end
  end
end