class ContractorsController < InheritedResources::Base
  respond_to :html, :json, :js
  before_filter :authenticate_contractor!, :only => [:dashboard, :update, :company_info, :edit_profile ]

  def index
    if params[:query]
      @contractors = Contractor.approved.search(params[:query].upcase).page(params[:page]).per_page(5)
    else
      @contractors = Contractor.approved.paginate(:page => params[:page], :per_page => 5)
    end
    @page_title = "Compassion for Humanity's Approved Contractors"
  end

  def new
    @page_title = "Register as a Contractor"
  end

  def show
    @contractor = Contractor.find(params[:id])
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
    @projects = @contractor.projects
    @galleries = get_galleries(@contractor)
  end

  def company_info
    @contractor = current_contractor
    @page_title = "Company Info - #{@contractor.name}"
  end

  def edit_profile
    @contractor = current_contractor
    @page_title = "Edit Profile - #{@contractor.name}"
  end

  def update
    @contractor = current_contractor

    if params[:contractor][:password].blank?
      params[:contractor].delete(:password)
      params[:contractor].delete(:password_confirmation)
    end
    if @contractor.update_attributes(contractor_params)
      respond_with @contractor
    else
      respond_with @contractor.errors.full_messages
    end
  end

  def search
    @results = Contractor.search_by_name(params[:name])
    @project = Project.find(params[:project_id])
    if @results.any?
      respond_with @results
    else
      respond_with "No Contractor Found"
    end
  end

  def get_galleries(contractor)
    @galleries = contractor.galleries
  end

  private

  def get_contractor
    @contractor = Contractor.find(params[:id])
  end

  def contractor_params
    params.require(:contractor).permit(:email, :password, :password_confirmation, :street_address, :city, :state, :zip_code, :name, :owner_phone, :cell_phone, :latitude, :longitude, :coverage_radius, :logo, :business_legal_name, :business_dba_name, :date_of_incorporation, :owner_first_name, :owner_last_name, :owner_email, :mailing_address, :mailing_address2, :mailing_zip_code, :mailing_city, :mailing_state, :mailing_same, :business_tax_id_no, :ein, :number_of_employees, :contractor_license_number, :gross_annual_sales_last_year, :description, :email, :status, :terms, :preferred, :website_url, :slug, :gmaps, :notify_on_select, :notify_on_review, :trade_ids)
  end
end
