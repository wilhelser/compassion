class CreateCategoriesProjects < ActiveRecord::Migration
  def change
    create_table :categories_projects, :id => false do |t|
      t.references :category, :project
    end

    add_index :categories_projects, [:category_id, :project_id],
      name: "categories_projects_index",
      unique: true
  end
end
