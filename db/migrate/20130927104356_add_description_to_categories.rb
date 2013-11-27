class AddDescriptionToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :description, :text
    add_column :categories, :icon, :string
  end
end
