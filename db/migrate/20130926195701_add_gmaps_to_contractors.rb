class AddGmapsToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :gmaps, :boolean
  end
end
