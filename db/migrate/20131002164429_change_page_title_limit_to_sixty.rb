class ChangePageTitleLimitToSixty < ActiveRecord::Migration
  def change
    change_column :projects, :page_title, :string, :limit => 60
  end
end
