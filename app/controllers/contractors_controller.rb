class ContractorsController < InheritedResources::Base
  respond_to :html, :json, :js
  before_filter :authenticate_contractor!, :only => [:dashboard]

  def index
    @search = Contractor.search(params[:q])
    if params[:q]
      @contractors = @search.result(distinct: true)
    else
      @contractors = Contractor.approved
    end
    @page_title = "Approved Contractors"
  end

  def new
    @page_title = "Register as a Contractor"
    @contractor = Contractor.new
  end

  def show
    @contractor = Contractor.friendly.find(params[:id])
    if params[:fromdash]
      @fromdash = true
    end
    @page_title = "#{@contractor.name} - #{@contractor.city}, #{@contractor.state}"
    @projects = @contractor.projects
    @gmap = @contractor.to_gmaps4rails
    @contractor_reviews = @contractor.contractor_reviews
    @galleries = get_galleries(@contractor)
  end

  def dashboard
    @contractor = current_contractor
    @page_title = "Dashboard - #{@contractor.name}"
    @references = @contractor.references
    @projects = @contractor.projects
    @galleries = get_galleries(@contractor)
  end

  def search
    @contractor = Contractor.find_by_name(params[:name])
    @project = Project.find(params[:project_id])
    if @contractor.nil?
      respond_with "No Contractor Found"
    else
      respond_with @contractor
    end
  end

  def get_galleries(contractor)
    @galleries = contractor.galleries
  end
end
