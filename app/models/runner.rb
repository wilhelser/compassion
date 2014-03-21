class Runner

  def execute
    run_adjuster_tasks
  end

  def run_adjuster_tasks
    @assignments_needing_accepted = find_assignments_needing_accepted
    @assignments_needing_estimate = find_assignments_needing_estimate
  end

  def run_action_tasks
    email_inactive_projects
  end


  def find_assignments_needing_accepted
    Assignment.needs_accepted.where('created_at' < Date.today)
  end

  def find_assignments_needing_estimate
    @assignments = []
    Assignment.accepted.each do |a|
      if a.project.estimates.size < 1
        @assignments << a
      end
    end
    return @assignments
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

  #
  # Method to find projects not funded in X number of days
  # @param  number_of_days [integer] number of days
  #
  # @return [Hash] projects not funded
  def projects_not_funded(number_of_days)
    Project.where(:created_at => Date.today - number_of_days.days)
  end
end
