class HomeController < ApplicationController
  include FriendsProjects
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
    @oauth = Koala::Facebook::OAuth.new(231408540317089,"7758a40a88cf75e51df02496c4390078", "http://compassionforhumanity.org")
    @oauth_url = @oauth.url_for_oauth_code
    if params[:code]
      @cookie = params[:code]
      @token = @oauth.get_access_token(@cookie)
      session[:temp_token] = @token
      @projects_from_friends = no_user_get_friends_projects(@token)
      @friends_projects = @projects_from_friends.first(4)
    end
  end

end
