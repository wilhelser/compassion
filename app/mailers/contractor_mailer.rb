class ContractorMailer < ActionMailer::Base
  default from: "postmaster@compassionforhumanity.org"

  #
  # Emails Compassion when a new contractor registers
  # @param  contractor [Object] contractor
  #
  def contractor_signup_notification(contractor)
    @contractor = contractor
    mail(to: 'corey@ihaveintegrity.com', bcc: "wil@wilhelser.com", subject: "New Contractor Registration.")
  end

  #
  # Emails contractor when they've been selected for a project
  # @param  contractor [Object] contractor
  # @param  project [Object] project
  # @param  user [Object] user
  # @param  adjuster [Object] adjuster
  #
  def contractor_selected_notification(contractor, project, user, adjuster)
    @user = user
    @project = project
    @contractor = contractor
    @adjuster = adjuster
    mail(to: @contractor.email, bcc: "wil@wilhelser.com", subject: "#{@contractor.owner_first_name}, you've been selected for a project!")
  end

  def new_adjuster_assigned_notification(project, contractor, user, adjuster)
    @user = user
    @project = project
    @contractor = contractor
    @adjuster = adjuster
    mail(to: @contractor.email, bcc: "wil@wilhelser.com", subject: "#{@contractor.owner_first_name}, a new adjuster has been assigned to one of your Actions!")
  end

  #
  # Emails contractor when they've been selected for a project that doesn't
  # have an available adjuster
  #
  # @param  contractor [Object] contractor
  # @param  project [Object] project
  # @param  user [Object] user
  #
  def contractor_selected_no_adjuster_notification(project, contractor, user)
    @user = user
    @project = project
    @contractor = contractor
    mail(to: @contractor.email, bcc: "wil@wilhelser.com", subject: "#{@contractor.owner_first_name}, you've been selected for a project!")
  end

  #
  # Emails contractor when they receive a review
  # @param  contractor [Object] contractor
  # @param  user [Object] user
  # @param  project [Object] project
  # @param  review [Object] review
  #
  def contractor_review_notification(contractor, user, project, review)
    @user = user
    @review = review
    @contractor = contractor
    @project = project
    mail(to: @contractor.email, bcc: "wil@wilhelser.com", subject: "#{@contractor.owner_first_name}, you've received a review!")
  end
end
