module ProjectMethods

  # sends email to action creator when action is funded
  # called from set_to_funded in Project model
  def send_funded_email
    ProjectMailer.project_funded_email(self.user, self).deliver
  end


  # clean out any random div tags that may have made their way into the
  # page message
  #
  # @return [type] [description]
  def clean_page_message_content
    @body = self.page_message
    if @body.include?('<div>')
      @newbody = @body.gsub('<div>', '').gsub('</div>', '')
      self.update_attribute('page_message', @newbody)
    end
  end

  def email_all_over_thirty_days
    @projects = Project.in_progress.where('created_at < ?', Date.today - 30.days)
    @projects.each do |p|
      @days = (Date.today.to_date - p.created_at.to_date).round
      ProjectMailer.project_not_funded_email(p.user, p, @days).deliver
    end
  end

  # Checks for inactive actions and sends an email
  # called from config/schedule.rb
  def email_inactive_projects
    @thirty_day_projects = projects_not_funded(30)
    @forty_day_projects = projects_not_funded(40)
    @fifty_day_projects = projects_not_funded(50)
    @sixty_day_projects = projects_not_funded(60)

    @thirty_day_projects.each do |p|
      ProjectMailer.project_not_funded_email(p.user, p, 30).deliver
    end

    @forty_day_projects.each do |p|
      ProjectMailer.project_not_funded_email(p.user, p, 40).deliver
    end

    @fifty_day_projects.each do |p|
      ProjectMailer.project_not_funded_email(p.user, p, 50).deliver
    end

    @sixty_day_projects.each do |p|
      ProjectMailer.project_not_funded_email(p.user, p, 60).deliver
    end

  end

  # method to find projects not funded in X number of days
  # @param  number_of_days Integer number of days project has been active
  #
  # @return Hash has of projects
  def projects_not_funded(number_of_days)
    Project.in_progress.where(:created_at => Date.today - number_of_days.days)
  end
end
