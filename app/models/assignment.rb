class Assignment < ActiveRecord::Base
  include ContractorMethods
  attr_accessible :adjuster_id, :project_id
  belongs_to :project
  belongs_to :adjuster
  before_destroy :create_new_assignment

  def create_new_assignment
    project = self.project
    adjuster = self.adjuster
    reassign_adjuster(project, adjuster)
  end
end
