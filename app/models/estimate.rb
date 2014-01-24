class Estimate < ActiveRecord::Base
  attr_accessible :adjuster_id, :amount, :description, :document, :project_id
  belongs_to :project, touch: true
  validates :adjuster_id, :project_id, :amount, :description, :document, :presence => true
  validates_numericality_of :amount, :message => "must not contain any punctuation"
  belongs_to :adjuster
  mount_uploader :document, EstimateUploader
  after_create :destroy_assignment

  #
  # Destroys assignment when adjuster uploads an estimate
  #
  def destroy_assignment
    @project = Project.find(self.project_id)
    @assignment = @project.assignments.first
    @assignment.destroy
    AdjusterMailer.new_estimate_uploaded(@project, @project.contractors.first, self.adjuster).deliver
    set_project_to_approved(@project)
  end

  #
  # Sets project to approved after an estimate has been uploaded
  # @param  project [Object] project
  #
  def set_project_to_approved(project)
    @project = project
    @project.update_attributes(:approved => true, :goal_amount => self.amount)
  end
end
