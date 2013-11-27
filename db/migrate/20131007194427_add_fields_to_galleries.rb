class AddFieldsToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :type, :string, :null => false
    add_column :galleries, :contractor_id, :integer
  end
end
