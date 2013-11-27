class AddDeadlineToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :project_deadline, :date
    add_column :projects, :reason_for_deadline, :text
  end
end
