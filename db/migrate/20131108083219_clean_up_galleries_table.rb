class CleanUpGalleriesTable < ActiveRecord::Migration
  def change
    remove_column :galleries, :type
    remove_column :galleries, :images
  end
end
