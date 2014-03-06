class VendorsController < InheritedResources::Base
  respond_to :html, :js, :json

  def index
    @project = Project.friendly.find(params[:project_id])
    @vendors = @project.vendors
    @page_title = "Vendors"
  end

  def create
    @project = Project.find(params[:project_id])
    @vendor = @project.vendors.build(params[:vendor])

    if @vendor.save
      @vendors = @project.vendors
      @project.update_goal_amount
      respond_with @vendor
    else
      respond_with @vendor.errors.full_messages
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
    respond_with @vendor
  end

  def update
    @vendor = Vendor.find(params[:id])
    @project = Project.find(@vendor.project_id)

    if @vendor.update_attributes(params[:vendor])
      @vendors = @project.vendors
      @project.update_goal_amount
      respond_with @vendor
    else
      respond_with @vendor.errors.full_messages
    end
  end

  def destroy
    @vendor = Vendor.find(params[:id])
    @project = Project.find(@vendor.project_id)
    @vendor.destroy
    @vendors = @project.vendors
    @project.update_goal_amount
  end

end
