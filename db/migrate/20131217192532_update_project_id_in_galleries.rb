class UpdateProjectIdInGalleries < ActiveRecord::Migration
  def change
    change_column :galleries, :project_id, :integer, :null => true
  end
end
