class AddEmailNotificationToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :notify_on_donate, :boolean
  end
end
