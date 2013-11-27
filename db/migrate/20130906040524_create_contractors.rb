class CreateContractors < ActiveRecord::Migration
  def change
    create_table :contractors do |t|
      t.string :name, :null => false
      t.string :address, :null => false
      t.string :city, :null => false
      t.string :state, :null => false
      t.integer :zip_code, :limit => 5, :null => false
      t.float :latitude
      t.float :longitude
      t.integer :coverage_radius, :null => false
      t.string :logo

      t.timestamps
    end
  end
end
