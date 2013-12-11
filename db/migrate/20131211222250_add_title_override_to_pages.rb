class AddTitleOverrideToPages < ActiveRecord::Migration
  def change
    add_column :pages, :title_override, :string
  end
end
