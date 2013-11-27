class AddGeocodeFieldsToAdjusters < ActiveRecord::Migration
  def change
    add_column :adjusters, :latitude, :float
    add_column :adjusters, :longitude, :float
  end
end
