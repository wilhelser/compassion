class AddPublicToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :public, :boolean, :default => true
  end
end
