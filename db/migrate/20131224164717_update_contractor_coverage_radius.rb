class UpdateContractorCoverageRadius < ActiveRecord::Migration
  def change
    change_column :contractors, :coverage_radius, :integer, :default => 25, :null => true
  end
end
