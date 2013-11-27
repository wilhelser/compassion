class AddCityStateZipToUsers < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :state, :string, :limit => 2
    add_column :users, :zip_code, :integer, :limit => 5
  end
end
