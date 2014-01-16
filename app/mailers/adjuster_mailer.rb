class AdjusterMailer < ActionMailer::Base
  default from: "postmaster@compassionforhumanity.org"

  def adjuster_signup_notification(adjuster)
    @adjuster = adjuster
    mail(to: 'corey@ihaveintegrity.com', bcc: "wil@wilhelser.com", subject: "New Adjuster Registration.")
  end

  def adjuster_selected_notification(contractor, project, user, adjuster)
    @user = user
    @project = project
    @contractor = contractor
    @adjuster = adjuster
    mail(to: @adjuster.email, bcc: "wil@wilhelser.com,corey@ihaveintegrity.com", subject: "#{@adjuster.first_name}, you've been selected for a project!")
  end

  def no_adjuster_found(project, contractor, user)
    @project = project
    @contractor = contractor
    mail(to: "corey@ihaveintegrity.com", bcc: "wil@wilhelser.com", subject: "No Adjuster within 50 miles found for project!")
  end

  def new_estimate_uploaded(project, contractor, adjuster)
    @project = project
    @contractor = contractor
    @adjuster = adjuster
    mail(to: "corey@ihaveintegrity.com", bcc: "wil@wilhelser.com", subject: "New Estimate Uploaded!")
  end
end
