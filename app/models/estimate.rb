class Estimate < ActiveRecord::Base
  attr_accessible :adjuster_id, :amount, :description, :document, :project_id
  belongs_to :project
  validates :adjuster_id, :project_id, :amount, :description, :document, :presence => true
  belongs_to :adjuster
  mount_uploader :document, EstimateUploader
  after_create :destroy_assignment

  def destroy_assignment
    @project = Project.find(self.project_id)
    @assignment = @project.assignments.first
    @assignment.destroy
    AdjusterMailer.new_estimate_uploaded(@project, @project.contractors.first, self.adjuster).deliver
    set_project_to_approved(@project)
  end

  def set_project_to_approved(project)
    @project = project
    @project.update_attributes(:approved => true, :goal_amount => self.amount)
  end
end
