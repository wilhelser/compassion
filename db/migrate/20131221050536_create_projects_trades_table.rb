class CreateProjectsTradesTable < ActiveRecord::Migration
  def change
    create_table :projects_trades, id: false do |t|
      t.integer :project_id, null: false
      t.integer :trade_id, null: false
    end
  end
end
