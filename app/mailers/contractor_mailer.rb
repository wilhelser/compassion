class ContractorMailer < ActionMailer::Base
  default from: "postmaster@compassionforhumanity.org"

  def contractor_selected_notification(contractor, project, user, adjuster)
    @user = user
    @project = project
    @contractor = contractor
    @adjuster = adjuster
    mail(to: @contractor.email, bcc: "wil@wilhelser.com", subject: "#{@contractor.owner_first_name}, you've been selected for a project!")
  end

  def contractor_selected_no_adjuster_notification(contractor, project, user)
    @user = user
    @project = project
    @contractor = contractor
    mail(to: @contractor.email, bcc: "wil@wilhelser.com", subject: "#{@contractor.owner_first_name}, you've been selected for a project!")
  end

  def contractor_review_notification(contractor, user, project, review)
    @user = user
    @review = review
    @contractor = contractor
    @project = project
    mail(to: @contractor.email, bcc: "wil@wilhelser.com", subject: "#{@contractor.owner_first_name}, you've received a review!")
  end
end
