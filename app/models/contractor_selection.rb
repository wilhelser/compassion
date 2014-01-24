class ContractorSelection < ActiveRecord::Base
  include ContractorMethods
  belongs_to :project
  belongs_to :contractor
  attr_accessible :contractor_id, :project_id
  after_create :send_contractor_notification

  def send_contractor_notification
    @contractor = self.contractor
    @project = self.project
    @user = @project.user
    @adjuster = find_closest_adjuster(@project)
    if @adjuster.nil?
      Rails.logger.info "No Adjuster nearby yo!"
      ContractorMailer.contractor_selected_no_adjuster_notification(@contractor, @project, @user).deliver
    else
      Rails.logger.info "Found an Adjuster!"
      AdjusterMailer.adjuster_selected_notification(@contractor, @project, @user, @adjuster).deliver
      ContractorMailer.contractor_selected_notification(@contractor, @project, @user, @adjuster).deliver
    end
  end
end
