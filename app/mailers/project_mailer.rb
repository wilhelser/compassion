class ProjectMailer < ActionMailer::Base
  default from: "postmaster@compassionforhumanity.org"

  def new_project_user_email(user, project)
    @user = user
    @project = project
    mail(to: @user.email, subject: 'Thank you for creating a new project!')
  end

  def project_not_funded_email(user, project, days)
    @user = user
    @project = project
    @days = days
    mail(to: @user.email, subject: 'Aw, Shucks!')
  end
end
