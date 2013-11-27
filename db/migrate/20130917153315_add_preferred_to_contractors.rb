class AddPreferredToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :preferred, :boolean, :default => false
  end
end
