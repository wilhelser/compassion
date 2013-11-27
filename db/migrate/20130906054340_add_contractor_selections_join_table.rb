class AddContractorSelectionsJoinTable < ActiveRecord::Migration
  def change
    create_table :contractor_selections, :id => false do |t|
      t.references :contractor, :project
    end
  end
end