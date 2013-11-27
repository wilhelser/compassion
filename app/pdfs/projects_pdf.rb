class ProjectsPdf < Prawn::Document
  def initialize(projects)
    super(top_margin: 70, page_layout: :landscape)
    @projects = projects
    page_heading
    project_items
  end

  def page_heading
    text "Projects (#{@projects.size})", size: 30, style: :bold
    text "Report Generated: #{Date.today}", size: 14, style: :italic
  end

  def project_items
    move_down 20
    table project_item_rows do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def project_item_rows
    [["ID", "User", "Goal Amount", "Total Contributions", "Percent Funded", "Status", "Project Deadline", "Project State"]] +
    @projects.map do |project|
      [project.id, project.user.first_name + " " + project.user.last_name, project.goal_amount, project.total_contributions, project.percent_funded.round(2), project.status, project.project_deadline, project.state]
    end
  end

end