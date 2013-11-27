class AddStatusToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :status, :string, :null => false, :default => "Not Submitted"
  end
end
