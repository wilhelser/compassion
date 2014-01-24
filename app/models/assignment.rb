class Assignment < ActiveRecord::Base
  include ContractorMethods
  attr_accessible :adjuster_id, :project_id
  belongs_to :project
  belongs_to :adjuster

  def reassign
    project = self.project
    adjuster = self.adjuster

  end
end
