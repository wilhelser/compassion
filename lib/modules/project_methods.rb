module ProjectMethods
  def send_funded_email
    ProjectMailer.project_funded_email(self.user, self).deliver
  end

  # Checks for inactive actions and sends an email
  # called from config/schedule.rb
  def email_inactive
    @thirty_day_projects = projects_not_funded(30)
    @forty_day_projects = projects_not_funded(40)
    @fifty_day_projects = projects_not_funded(50)
    @sixty_day_projects = projects_not_funded(60)

    @thirty_day_projects.each do |p|
      ProjectMailer.project_not_funded(p.user, p, 30).deliver
    end

    @forty_day_projects.each do |p|
      ProjectMailer.project_not_funded(p.user, p, 40).deliver
    end

    @fifty_day_projects.each do |p|
      ProjectMailer.project_not_funded(p.user, p, 50).deliver
    end

    @sixty_day_projects.each do |p|
      ProjectMailer.project_not_funded_email(p.user, p, 60).deliver
    end

  end

  def projects_not_funded(number_of_days)
    Project.where(:created_at => Date.today - number_of_days.days)
  end

end
