class AddFeaturedFieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :featured_image, :string
    add_column :projects, :featured_video, :string
  end
end
