module ContractorMethods

  def find_closest_adjuster(project)
    @project = self.project
    @adjuster_within_fifty = Adjuster.near(@project, 50).pluck(:id).to_a
    @adjuster_within_hundred = Adjuster.near(@project, 100).pluck(:id).to_a
    if @adjuster_within_fifty.any?
      @adjuster = @adjuster_within_fifty.first
    elsif @adjuster_within_hundred.any?
      send_no_adjuster_mailer(@project)
      @adjuster = @adjuster_within_hundred.first
    else
      send_no_adjuster_mailer(@project)
      @adjuster = nil
    end
    create_assignment(@project, @adjuster)
    return Adjuster.find(@adjuster)
  end


  def send_no_adjuster_mailer(project)
    AdjusterMailer.no_adjuster_found(@project, @project.contractors.first, @project.user).deliver
  end

  def create_assignment(project, adjuster)
    Assignment.create(:project_id => project.id, :adjuster_id => adjuster)
  end

end
