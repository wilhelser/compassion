class RemoveCountryFromBackers < ActiveRecord::Migration
  def change
    remove_column :backers, :country
  end
end
