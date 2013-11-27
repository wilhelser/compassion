class AddImagesToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :images, :string
  end
end
