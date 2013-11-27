class AddPrimaryKeyToContractorSelections < ActiveRecord::Migration
  def change
    add_column :contractor_selections, :id, :primary_key
  end
end
