class CreateContractorStatuses < ActiveRecord::Migration
  def change
    create_table :contractor_statuses do |t|
      t.string :text, limit: 20, null: false

      t.timestamps
    end
  end
end
