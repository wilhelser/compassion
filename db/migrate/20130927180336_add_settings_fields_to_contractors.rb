class AddSettingsFieldsToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :notify_on_select, :boolean, :default => true
    add_column :contractors, :notify_on_review, :boolean, :default => true
  end
end
