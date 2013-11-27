class UpdatesController < InheritedResources::Base
  # before_filter :get_project, :except => [:create]
  respond_to :html, :json, :js

  def create
    @update = Update.new(params[:update])
    @project = Project.find(params[:project_id])
    @updates = @project.updates
    if @update.save
      respond_with @update
    else
      render :json => @update.errors, :status => :unprocessable_entity
    end
  end

  private

  def get_project
    @project = Project.find(params[:id])
  end
end
