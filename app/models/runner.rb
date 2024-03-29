class Runner
  include ContractorMethods

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
    Assignment.needs_accepted.created(Date.today - 1)
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
      ProjectMailer.delay(run_at: 2.minutes.from_now).project_not_funded(p.user, p, 30)
    end

    @forty_day_projects.each do |p|
      ProjectMailer.delay(run_at: 3.minutes.from_now).project_not_funded(p.user, p, 40)
    end

    @fifty_day_projects.each do |p|
      ProjectMailer.delay(run_at: 4.minutes.from_now).project_not_funded(p.user, p, 50)
    end

    @sixty_day_projects.each do |p|
      ProjectMailer.delay(run_at: 5.minutes.from_now).project_not_funded_email(p.user, p, 60)
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
