class ProjectMailer < ActionMailer::Base
  default from: "postmaster@compassionforhumanity.org"

  def new_project_user_email(user, project)
    @user = user
    @project = project
    mail(to: @user.email, subject: "#{@user.first_name}, thank you for creating a new ACTION!")
  end

  def project_not_funded_email(user, project, days)
    @user = user
    @project = project
    @days = days
    mail(to: @user.email, subject: 'Aw, Shucks!')
  end

  def project_funded_email(user, project)
    @user = user
    @project = project
    mail(to: @user.email, subject: "#{@user.first_name}, your ACTION has been funded!")
  end

  def needs_action_email(user, project)
    @user = user
    @project = project
    mail(to: @user.email, subject: "#{@user.first_name}, your ACTION needs activity!")
  end

  def end_action_email(user, project)
    @user = user
    @project = project
    mail(to: @user.email, subject: "End your ACTION!")
  end

  def action_stopped_email(user, project)
    @user = user
    @project = project
    mail(to: @user.email, subject: "Your ACTION has been stopped!")
  end
end
