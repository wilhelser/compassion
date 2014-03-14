class ProjectsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show, :donate, :thank_you, :share_on_facebook ]
  # load_resource :find_by => :slug
  # load_and_authorize_resource :only => [:update, :edit, :dashboard]
  before_filter :set_user
  # before_filter :parse_facebook_cookies
  before_filter :get_project, :except => [:index, :new, :create, :show]
  before_filter :get_categories
  respond_to :html, :json, :js, :pdf, :png

  def index
    @categories = Category.all
    @query = params[:query]
    @projects = Project.approved.text_search(params[:query].upcase).page(params[:page]).per_page(4)
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
    @project = Project.new
    @page_title = "Create an Action"
  end

  def create
    @user = current_user
    @project = @user.projects.build(params[:project])

    if @project.save
      respond_with @project
    else
      respond_with @project.errors.full_messages
    end
  end

  def edit
    @page_title = "Edit Your Action"
  end

  def dashboard
    @project = Project.friendly.find(params[:id])
    @graph = Koala::Facebook::API.new(current_user.token)
    session[:project_id] = @project.id
    @page_title = "Dashboard - #{@project.page_title}"
    @updates = @project.updates
    @deletable = true
  end

  def show
    @the_project = Project.friendly.find(params[:id])
    @project = @the_project.decorate
    @page_title = @project.page_title
    @contribution = Contribution.new
    # if @project.has_estimate?
    #   @estimates = @project.estimates
    # end
    respond_to do |format|
      format.html
      format.json { render json: @the_project}
      format.js
      format.png { render :qrcode => @project.long_link }
      format.pdf do
        pdf = ProjectPdf.new(@the_project, view_context)
          send_data pdf.render, filename: "#{@the_project.slug}.pdf",
                                type: "application/pdf",
                                disposition: "inline"
      end
    end
  end

  def contractor
    if @project.contractors.size > 0
      @contractor = @project.contractors.last
    else
      @contractors = @project.nearby_contractors
    end
    @page_title = "Contractor"
  end

  def settings
    @page_title = "Action Settings"
  end

  def share
    @page_title = "Share Your Action"
  end

  def action_galleries
    @page_title = "Galleries"
    @galleries = @project.galleries
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
  end

  def extend_campaign
    @project.extend_campaign
  end

  def thank_you
    @contribution = Contribution.find(params[:c])
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
