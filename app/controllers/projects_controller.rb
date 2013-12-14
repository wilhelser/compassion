class ProjectsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show, :donate, :thank_you ]
  load_and_authorize_resource :only => [:update, :edit, :dashboard, :end_campaign]
  before_filter :set_user
  before_filter :parse_facebook_cookies
  before_filter :get_project, :except => [:index, :new, :create, :dashboard]
  before_filter :get_categories
  respond_to :html, :json, :js, :pdf

  def index
    @categories = Category.all
    @query = params[:query]
    @projects = Project.text_search(params[:query]).page(params[:page]).per_page(4)
    @page_title = "#{@projects.size} Search Results for \"#{@query}\""
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @projects }
      format.js
      format.pdf do
        pdf = ProjectsPdf.new(@projects)
          send_data pdf.render, filename: "projects_report.pdf",
                                type: "application/pdf",
                                disposition: "inline"
       end
    end
  end

  def new
    @user = current_user
    @project = @user.projects.build
    @page_title = "Create a Project"
  end

  def create
    @user = current_user
    @project = @user.projects.build(params[:project])

    if @project.save
      redirect_to dashboard_project_path(@project)
    else
      render :new
    end
  end

  def dashboard
    @graph = Koala::Facebook::API.new(current_user.token)
    session[:project_id] = @project.id
    @page_title = @project.page_title
    @updates = @project.updates
    if @project.needs_vendors
      @vendor = Vendor.new
      @vendors = @project.vendors
    end
    if @project.has_galleries?
      @galleries = @project.galleries
    end
    if @project.contractors.size > 0
      @contractor = @project.contractors.last
    else
      @contractors = Contractor.near(@project, 200)
    end
    if @project.has_estimate?
      @estimates = @project.estimates
    end
    @deletable = true
  end

  def show
    @project = Project.friendly.find(params[:id])
    @updates = @project.updates
    @page_title = @project.page_title
    @contributions = @project.contributions
    @recent_contributions = @project.recent_contributions
    @galleries = @project.galleries
    @contribution = Contribution.new
    if @project.has_estimate?
      @estimates = @project.estimates
    end
  end

  def destroy
    @project.destroy
    redirect_to dashboard_user_path(current_user)
    flash[:notice] = 'Successfully deleted your project!'
  end

  def donate
    @contribution = Contribution.new
    @page_title = "Donate to: #{@project.page_title}"
  end

  def end_campaign

  end

  def thank_you
    @page_title = "Thank you for your support!"
  end

  def share_on_facebook
    @token = current_user.token
    @graph = Koala::Facebook::API.new(@token)
    @graph.put_connections("me", "comphuman:donate", :project => @project.long_link)
  end

  def select_project_contractor
    @project = Project.find(params[:project_id])
    @contractor = Contractor.find(params[:contractor_id])
    respond_with @contractor
  end

  private

  def set_user
    @user = current_user
  end

  def get_project
    @project = Project.friendly.find(params[:id])
  end

  def get_categories
    @categories = Category.all
  end

  def parse_facebook_cookies
    @facebook_cookies ||= Koala::Facebook::OAuth.new(ENV['FB_APP_ID'], ENV['FB_SECRET_KEY']).get_user_info_from_cookie(cookies)

    # @access_token = @facebook_cookies["access_token"]
    # @graph = Koala::Facebook::GraphAPI.new(@access_token)
  end
end
