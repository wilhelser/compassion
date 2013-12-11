class HomeController < ApplicationController
  layout Proc.new { |controller| controller.request.xhr?? false : 'application' }
  respond_to :html, :json, :js

  def index
    @projects = Project.approved.limit(3)
    @categories = Category.all
    @projects_near_me = Project.approved.near([@lat, @long], 50).limit(3)
  end

end
