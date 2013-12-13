class CategoriesController < ApplicationController
  respond_to :html, :json, :js

  def show
    if params[:id] == "all"
      @projects = Project.all
      @page_title = "All Projects"
    elsif params[:id] == 'nearby'
      @projects = Project.approved.near([@lat, @long], 50)
      @page_title = "Projects Near: #{@location_city}"
    else
      @category = Category.friendly.find(params[:id])
      @projects = @category.projects.approved
      @page_title = "#{@category.name}"
    end
    @categories = Category.all
  end
end
