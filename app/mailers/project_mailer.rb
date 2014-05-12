class ProjectMailer < ActionMailer::Base
  default from: "postmaster@compassionforhumanity.org"

  #
  # Emails user after they create a project
  # @param  user [Object] user
  # @param  project [Object] project
  #
  def new_project_user_email(user, project)
    @user = user
    @project = project
    mail(to: @user.email, subject: "#{@user.first_name}, thank you for creating a new ACTION!")
  end

  #
  # Emails Compassion when a project is created and has no approved
  # contractors in the area
  #
  # @param  user [Object] user
  # @param  project [Object] project
  #
  def no_contractor_notification(user, project)
    @user = user
    @project = project
    mail(to: 'corey@ihaveintegrity.com', bcc: 'wil@wilhelser.com', subject: "No Contractors Available for Action")
  end

  #
  # Emails user when project hasn't been funded in certain number of days
  # @param  user [Object] user
  # @param  project [Object] project
  # @param  days [Integer] number of days
  #
  def project_not_funded_email(user, project, days)
    @user = user
    @project = project
    @days = days
    mail(to: @user.email, subject: 'Aw, Shucks!')
  end

  #
  # Emails user when their project is funded
  # @param  user [Object] user
  # @param  project [Object] project
  #
  def project_funded_email(user, project)
    @user = user
    @project = project
    mail(to: @user.email, subject: "#{@user.first_name}, your ACTION has been funded!")
  end

  #
  # Emails user when their project needs activity
  # @param  user [Object] user
  # @param  project [Object] project
  #
  def needs_action_email(user, project)
    @user = user
    @project = project
    mail(to: @user.email, subject: "#{@user.first_name}, your ACTION needs activity!")
  end

  #
  # Emails user when they need to end their Action
  # @param  user [Object] user
  # @param  project [Object] project
  #
  def end_action_email(user, project)
    @user = user
    @project = project
    mail(to: @user.email, subject: "End your ACTION!")
  end

  #
  # Emails user when their Action is automatically stopped
  # @param  user [Object] user
  # @param  project [Object] project
  #
  def action_stopped_email(user, project)
    @user = user
    @project = project
    mail(to: @user.email, subject: "Your ACTION has been stopped!")
  end

  #
  # Emails user after their project receives a donation
  # only sent if project settings have notify_on_donate set to true
  # @param  user [Object] user
  # @param  project [Object] project
  # @param  contribution [Object] contribution
  #
  def donation_notification_email(user, project, contribution)
    @user = user
    @project = project
    @contribution = contribution
    mail(to: @user.email, subject: "#{@user.first_name}, your Action #{@project.page_title} has received a new contribution!")
  end

  def admin_project_closed_email(user, project)
    @user = user
    @project = project
    mail(to: 'info@compassionforhumanity.org', subject: "#{@project.page_title} has been ended.")
  end
end
