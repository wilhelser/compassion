class ChangeCategoriesOrderNameToPosition < ActiveRecord::Migration
  def change
    rename_column :categories, :order, :position
  end
end
