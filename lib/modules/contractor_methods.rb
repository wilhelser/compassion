module ContractorMethods

  def find_closest_adjuster(project, options={})
    @project = project
    @adjuster_within_fifty = Adjuster.approved.near(@project, 50)
    @adjuster_within_hundred = Adjuster.approved.near(@project, 100)
    if @adjuster_within_fifty.any?
      @adjuster = @adjuster_within_fifty.shuffle.each.first
    elsif @adjuster_within_hundred.any?
      send_no_adjuster_within_fifty_mailer(@project)
      @adjuster = @adjuster_within_hundred.shuffle.each.first
    else
      send_no_adjuster_mailer(@project)
      @adjuster = nil
    end
    return Adjuster.find(@adjuster)
  end

  def reassign_adjuster(assignment, project, previous_adjuster)
    @assignment = assignment
    @project = project
    @previous_adjuster = previous_adjuster
    @adjuster_within_fifty = Adjuster.approved.where.not(id: @previous_adjuster.id).near(@project, 50)
    @adjuster_within_hundred = Adjuster.approved.where.not(id: @previous_adjuster.id).near(@project, 100)
    if @adjuster_within_fifty.any?
      @adjuster = @adjuster_within_fifty.shuffle.each.first
      @has_adjuster = true
    elsif @adjuster_within_hundred.any?
      send_no_adjuster_within_fifty_mailer(@project)
      @adjuster = @adjuster_within_hundred.shuffle.each.first
      @has_adjuster = true
    else
      send_no_adjuster_mailer(@project)
      @adjuster = nil
      @has_adjuster = false
    end
    if @has_adjuster == true
      @assignment.update_attribute('adjuster_id', @adjuster.id)
      send_contractor_reassignment_notification(@project, @adjuster)
    end
  end


  def send_contractor_reassignment_notification(project, adjuster)
    @adjuster = adjuster
    ContractorMailer.new_adjuster_assigned_notification(@project, @project.contractors.first, @project.user, @adjuster).deliver
  end

  def send_no_adjuster_within_fifty_mailer(project)
    AdjusterMailer.no_adjuster_found_within_fifty(@project, @project.contractors.first, @project.user).deliver
  end

  def send_no_adjuster_mailer(project)
    AdjusterMailer.no_adjuster_found(@project, @project.contractors.first, @project.user).deliver
  end

  def create_assignment(project, adjuster)
    Assignment.create(:project_id => project.id, :adjuster_id => adjuster.id)
  end

end
