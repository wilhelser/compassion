class ProjectsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show, :donate, :thank_you, :share_on_facebook ]
  # load_resource :find_by => :slug
  # load_and_authorize_resource :only => [:update, :edit, :dashboard]
  before_filter :set_user
  # before_filter :parse_facebook_cookies
  before_filter :get_project, :except => [:index, :new, :create]
  before_filter :get_categories
  respond_to :html, :json, :js, :pdf, :png

  def index
    @categories = Category.all
    @query = params[:query]
    @projects = Project.approved.text_search(params[:query]).page(params[:page]).per_page(4)
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
    @project = Project.friendly.find(params[:id])
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
    respond_to do |format|
      format.html
      format.json { render json: @project }
      format.js
      format.png { render :qrcode => request.url }
      format.pdf do
        pdf = ProjectPdf.new(@project, view_context)
          send_data pdf.render, filename: "#{@project.slug}.pdf",
                                type: "application/pdf",
                                disposition: "inline"
      end
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
    @project.end_campaign
    @page_title = "End Campaign"
  end

  def thank_you
    @oauth = Koala::Facebook::OAuth.new(231408540317089,"7758a40a88cf75e51df02496c4390078", "http://compassionforhumanity.org/projects/#{@project.id}/thank_you")
    @oauth_url = @oauth.url_for_oauth_code(:permissions => "publish_stream")
    if params[:code]
      @cookie = params[:code]
      @token = @oauth.get_access_token(@cookie)
      session[:temp_token] = @token
    end
    @page_title = "Thank you for your support!"
  end

  def share_on_facebook
    @token = session[:temp_token].blank? ? current_user.token : session[:temp_token]
    @graph = Koala::Facebook::API.new(@token)
    @graph.put_connections("me", "comphuman:donate", :project => @project.long_link)
    session[:temp_token] = ""
  end

  def share_created
    @token = current_user.token
    @graph = Koala::Facebook::API.new(@token)
    @graph.put_connections("me", "comphuman:create", :project => @project.long_link)
  end

  def select_project_contractor
    @project = Project.find(params[:project_id])
    @contractor = Contractor.find(params[:contractor_id])
    respond_with @contractor
  end

  def donate_remaining

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
