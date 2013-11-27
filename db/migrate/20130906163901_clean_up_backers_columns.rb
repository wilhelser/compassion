class CleanUpBackersColumns < ActiveRecord::Migration
  def change
    remove_column :backers, :zip_code
    remove_column :backers, :address
    remove_column :backers, :address_2
    remove_column :backers, :city
    remove_column :backers, :state
  end
end
