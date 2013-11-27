class RenameProjectCategoriesToCategories < ActiveRecord::Migration
  def change
    rename_table :project_categories, :categories
  end
end
