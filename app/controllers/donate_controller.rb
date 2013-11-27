class DonateController < ApplicationController
  before_filter :set_project_session

  def index
    @contribution = Contribution.new
    @page_title = "Donate to: #{@project.page_title}"
  end

  private
  def set_project_session
    if params[:project_id]
      @project = Project.find(params[:project_id])
      session[:project] = @project
    else
      @project = session[:project]
    end
  end

end
