class EstimatesController < InheritedResources::Base
  respond_to :html, :js, :json

  def new
    @project_id = request.GET[:project_id]
    @adjuster_id = request.GET[:adjuster_id]
    @project = Project.find(@project_id)
    @adjuster = Adjuster.find(@adjuster_id)
  end

  def create
    @estimate = Estimate.new(params[:estimate])
    @adjuster = Adjuster.find(params[:estimate][:adjuster_id])

    if @estimate.save
      @estimates = @adjuster.estimates
      respond_with @estimate
    else
      respond_with @estimate.errors.full_messages
    end
  end
end
