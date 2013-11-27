class RemoveZipFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :zip
  end
end
