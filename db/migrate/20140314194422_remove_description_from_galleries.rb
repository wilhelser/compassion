class RemoveDescriptionFromGalleries < ActiveRecord::Migration
  def change
    remove_column :galleries, :description
  end
end
