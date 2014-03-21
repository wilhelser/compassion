class AdjusterMailer < ActionMailer::Base
  default from: "postmaster@compassionforhumanity.org"

  #
  # Emails Compassion when new adjuster registers
  # @param  adjuster [Object] new adjuster
  #
  def adjuster_signup_notification(adjuster)
    @adjuster = adjuster
    mail(to: 'admin@compassionforhumanity.org', bcc: "wil@wilhelser.com", subject: "New Adjuster Registration.")
  end

  #
  # Notifies adjuster when they have been selected for a project
  # @param  contractor [Object] project's contractor
  # @param  project [Object] the project
  # @param  user [Object] the project's user
  # @param  adjuster [Object] adjuster
  #
  def adjuster_selected_notification(contractor, project, user, adjuster)
    @user = user
    @project = project
    @contractor = contractor
    @adjuster = adjuster
    mail(to: @adjuster.email, bcc: "wil@wilhelser.com,admin@compassionforhumanity.org", subject: "#{@adjuster.first_name}, you've been selected for a project!")
  end

  #
  # Emails Compassion when no adjuster is found for a project
  # @param  project [Object] project
  # @param  contractor [Object] contractor
  # @param  user [Object] user
  #
  def no_adjuster_found(project, contractor, user)
    @project = project
    @contractor = contractor
    mail(to: "admin@compassionforhumanity.org", bcc: "wil@wilhelser.com", subject: "No Adjuster found for project!")
  end

  #
  # Emails Compassion when no adjuster is found within 50 miles for a project
  # @param  project [Object] project
  # @param  contractor [Object] contractor
  # @param  user [Object] user
  #
  def no_adjuster_found_within_fifty(project, contractor, user, adjuster)
    @project = project
    @contractor = contractor
    @adjuster = adjuster
    mail(to: "admin@compassionforhumanity.org", bcc: "wil@wilhelser.com", subject: "No Adjuster within 50 miles found for project!")
  end

  #
  # Emails Compassion when a new estimate is uploaded
  # @param  project [Object] project
  # @param  contractor [Object] contractor
  # @param  adjuster [Object] adjuster
  #
  def new_estimate_uploaded(project, contractor, adjuster)
    @project = project
    @contractor = contractor
    @adjuster = adjuster
    mail(to: "admin@compassionforhumanity.org", bcc: "wil@wilhelser.com", subject: "New Estimate Uploaded!")
  end
end
