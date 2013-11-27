class AddTermsToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :terms, :boolean
  end
end
