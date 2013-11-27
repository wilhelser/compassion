class AddSlugFieldToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :slug, :string
    rename_column :contractors, :gross_anual_sales_last_year, :gross_annual_sales_last_year
    add_index :contractors, :slug, unique: true
  end
end
