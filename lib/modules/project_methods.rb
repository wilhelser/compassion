module ProjectMethods

  #
  # sends email to action creator when action is funded
  # called from set_to_funded in Project model
  #
  def send_funded_email
    ProjectMailer.project_funded_email(self.user, self).deliver
  end

  #
  # Checks if project needs to be set to funded and sets the project
  # to funded if so
  #
  def check_funded_status
    if self.total_contributions >= self.goal_amount
      set_to_funded
    else
      Rails.logger.info "Not yet!"
    end
  end

  #
  # Sets a project's status to funded and sends a funded notification
  # email out to user
  #
  def set_to_funded
    self.update_attributes(status: 'Funded', funded: true, funded_date: Date.today)
    unless self.construction_project?
      send_funded_email
    end
    # @graph = Koala::Facebook::API.new(compassion_access_token)
    # @graph.put_wall_post("Another Compassion project funded!", { :name => "#{self.page_title}", :description => "Funded!", :link => "http://compassionforhumanity.org/projects/#{self.slug}"})
  end

  #
  # Whether a campaign has been extended
  #
  # @return [Boolean] true if campaign extended_date.present?
  def campaign_extended?
    self.campaign_extended_date.blank? ? false : true
  end

  #
  # Checks if user has made a decision to continue or close a project
  # after it has been funded
  #
  # @return [Boolean] true if campaign_ended? or campaign_extended?
  def funded_decision_made?
    true if campaign_ended? || campaign_extended?
  end

  #
  # clean out any random div tags that may have made their way into the
  # page message
  #
  # @return [String] cleaned page_message
  def clean_page_message_content
    @body = self.page_message
    if @body.include?('<div>')
      @newbody = @body.gsub('<div>', '').gsub('</div>', '')
      self.update_attribute('page_message', @newbody)
    end
  end

  #
  # Ends a campaign. Set's the status to complete, approved to false and
  # sets the campaign_ended_date to current date
  #
  def end_campaign
    self.update_attributes(campaign_ended: true, status: "Complete", approved: false, campaign_ended_date: Date.today)
  end

  #
  # Extends a campaign that has been funded. Sets campaign_ended to false
  # status to 'In Progress', approved to true and campaign_extended_date
  # to current date
  #
  def extend_campaign
    self.update_attributes(campaign_ended: false, status: "In Progress", approved: true, campaign_extended_date: Date.today)
  end

  #
  # Checks for inactive actions and sends an email
  # called from config/schedule.rb
  #
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

  #
  # Method to find projects not funded in X number of days
  # @param  number_of_days [Integer] number of days project has been active
  #
  # @return [Hash] hash of projects
  def projects_not_funded(number_of_days)
    Project.in_progress.where(:created_at => Date.today - number_of_days.days)
  end
end
