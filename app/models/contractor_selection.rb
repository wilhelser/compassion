class ContractorSelection < ActiveRecord::Base
  belongs_to :project
  belongs_to :contractor
  attr_accessible :contractor_id, :project_id
  after_create :send_contractor_notification

  def send_contractor_notification
    @contractor = Contractor.find(self.contractor_id)
    @project = Project.find(self.project_id)
    @user = @project.user
    @adjuster = find_closest_adjuster
    if @adjuster.nil?
      Rails.logger.info "No Adjuster nearby yo!"
      ContractorMailer.contractor_selected_no_adjuster_notification(@contractor, @project, @user).deliver
    else
      Rails.logger.info "Found an Adjuster!"
      AdjusterMailer.adjuster_selected_notification(@contractor, @project, @user, @adjuster).deliver
      ContractorMailer.contractor_selected_notification(@contractor, @project, @user, @adjuster).deliver
      create_assignment(@project, @adjuster)
    end
  end

  private
  def find_closest_adjuster
    @project = Project.find(self.project_id)
    @adjuster_within_fifty = Adjuster.near(@project, 50)
    @adjuster_within_hundred = Adjuster.near(@project, 100)
    if @adjuster_within_fifty.any?
      @adjuster = @adjuster_within_fifty.first
    elsif @adjuster_within_hundred.any?
      AdjusterMailer.no_adjuster_found(@project, @project.contractors.first, @project.user).deliver
      @adjuster = @adjuster_within_hundred.first
    else
      AdjusterMailer.no_adjuster_found(@project, @project.contractors.first, @project.user).deliver
      @adjuster = nil
    end
    return @adjuster
  end

  def create_assignment(project, adjuster)
    Assignment.create(:project_id => project.id, :adjuster_id => adjuster.id)
  end
end
