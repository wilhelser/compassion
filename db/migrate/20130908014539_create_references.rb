class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.integer :contractor_id, :null => false
      t.string :reference_type, :null => false
      t.string :company_name
      t.string :time_affiliated
      t.string :contact_first_name, :null => false
      t.string :contact_last_name, :null => false
      t.string :address
      t.string :address2
      t.string :city, :null => false
      t.string :state, :null => false
      t.integer :zip_code
      t.string :phone_number
      t.string :email

      t.timestamps
    end
  end
end
