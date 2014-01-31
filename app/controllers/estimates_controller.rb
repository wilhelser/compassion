class EstimatesController < InheritedResources::Base
  respond_to :html, :js, :json
  before_filter :authenticate_adjuster!
  before_filter :set_adjuster

  def new
    @project_id = request.GET[:project_id]
    @adjuster_id = request.GET[:adjuster_id]
    @project = Project.find(@project_id)
  end

  def create
    @estimate = @adjuster.estimates.build(params[:estimate])
    @project = Project.find(params[:estimate][:project_id])

    if @estimate.save
      @estimates = @adjuster.estimates
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

    if @estimate.update_attributes(params[:estimate])
      @estimates = @adjuster.estimates
      @assignments = @adjuster.assignments
      respond_with @estimate
    else
      respond_with @estimate.errors.full_messages
    end
  end

  private

  def set_adjuster
    @adjuster = current_adjuster
  end
end
