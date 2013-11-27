class DeviseCreateAdjusters < ActiveRecord::Migration
  def change
    create_table(:adjusters) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.string :company
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :phone
      t.string :fax
      t.string :address, :null => false
      t.string :city, :null => false
      t.string :state, :null => false, :limit => 2
      t.integer :zip_code, :null => false, :limit => 10


      t.timestamps
    end

    add_index :adjusters, :email,                :unique => true
    add_index :adjusters, :reset_password_token, :unique => true
    # add_index :adjusters, :confirmation_token,   :unique => true
    # add_index :adjusters, :unlock_token,         :unique => true
  end
end
