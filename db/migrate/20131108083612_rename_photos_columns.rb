class RenamePhotosColumns < ActiveRecord::Migration
  def change
    rename_column :photos, :title, :caption
    remove_column :photos, :description
  end
end
