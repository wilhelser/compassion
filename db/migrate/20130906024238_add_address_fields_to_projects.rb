class AddAddressFieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :street_address, :string
    add_column :projects, :city, :string
    add_column :projects, :state, :string
    add_column :projects, :zip, :integer, :limit => 5
    add_column :projects, :latitude, :float
    add_column :projects, :longitude, :float
  end
end
