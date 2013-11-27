class MergeBackersAndContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :private, :boolean, :default => false
    add_column :contributions, :address, :string
    add_column :contributions, :address_2, :string
    add_column :contributions, :city, :string
    add_column :contributions, :email, :string
    add_column :contributions, :first_name, :string
    add_column :contributions, :last_name, :string
    add_column :contributions, :image, :string
    add_column :contributions, :state, :string, :limit => 2
    add_column :contributions, :zip_code, :string, :limit => 5
    remove_column :contributions, :public
    remove_column :contributions, :backer_id
  end
end
