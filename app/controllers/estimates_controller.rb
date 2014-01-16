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
    @project = Project.find(params[:estimate][:project_id])

    if @estimate.save
      @estimates = @adjuster.estimates
      @assignments = @adjuster.assignments
      respond_with @estimate
    else
      respond_with @estimate.errors.full_messages
    end
  end

  def edit
    @estimate = Estimate.find(params[:id])

    respond_with @estimate
  end

  def update
    @estimate = Estimate.find(params[:id])
    @estimates = @estimate.adjuster.estimates

    if @estimate.update_attributes(params[:estimate])
      respond_with @estimate
    else
      respond_with @esitmate.errors.full_messages
    end
  end
end
