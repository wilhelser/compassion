class AddSlugToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :slug, :string, :limit => 80
  end
end
