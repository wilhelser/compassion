class CategoriesController < ApplicationController
  respond_to :html, :json, :js

  def show
    if params[:id] == "all"
      @projects = Project.paginate(:page => params[:page], :per_page => 8)
      @page_title = "All Projects"
    elsif params[:id] == 'nearby'
      @projects = Project.approved.near([@lat, @long], 50).paginate(:page => params[:page], :per_page => 8)
      @page_title = "Projects Near: #{@location_city}"
    else
      @category = Category.friendly.find(params[:id])
      @projects = @category.projects.approved.paginate(:page => params[:page], :per_page => 8)
      @page_title = "#{@category.name}"
    end
    @categories = Category.all
  end
end
