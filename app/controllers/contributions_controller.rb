class ContributionsController < InheritedResources::Base
  respond_to :html, :json, :js
  before_filter :get_project, :only => [:create]

  def new
    @project = Project.find(params[:project_id])
    @contribution = Contribution.new
    # @contribution = @project.contributions.build
    @dollar_amount = session[:amount].to_i
    # @amount = @dollar_amount * 100
    @page_title = "Step 2: Payment Information"
  end

  def create
    @contribution = @project.contributions.build(params[:contribution])

    if @contribution.save_with_payment
      redirect_to "/projects/#{@project.id}/thank_you"
    else
      render :json => @contribution.errors, :status => :unprocessable_entity
    end
  end

  private

  def get_project
    @project = Project.find(params[:project_id])
  end
end
