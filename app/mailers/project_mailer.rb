class ProjectMailer < ActionMailer::Base
  default from: "postmaster@compassionforhumanity.org"

  def new_project_user_email(user, project)
    @user = user
    @project = project
    mail(to: @user.email, subject: 'Thank you for creating a new project!')
  end
end
