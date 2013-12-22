class HomeController < ApplicationController
  layout Proc.new { |controller| controller.request.xhr?? false : 'application' }
  respond_to :html, :json, :js

  def index
    @page_title = "Changing the World Together"
    @projects = Project.donatable.limit(4)
    @categories = Category.all
    @projects_near_me = Project.donatable.near([@lat, @long], 50).limit(4)
    if user_signed_in?
      @projects_from_friends = current_user.get_friends_projects
      @friends_projects = @projects_from_friends.first(4)
    end
  end

end
