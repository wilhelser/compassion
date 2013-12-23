class HomeController < ApplicationController
  include FriendsProjects
  layout Proc.new { |controller| controller.request.xhr?? false : 'application' }
  respond_to :html, :json, :js

  def index
    @page_title = "Changing the World Together"
    @categories = Category.all
    @projects_near_me = Project.donatable.near([@lat, @long], 50).limit(4)
    if user_signed_in?
      @projects_from_friends = current_user.get_friends_projects
      @friends_projects = @projects_from_friends.first(4)
    end
    @oauth = Koala::Facebook::OAuth.new(ENV['FB_APP_ID'],"#{ENV['FB_SECRET_KEY']}", "http://compassionforhumanity.org/home/fb_callback")
    @oauth_url = @oauth.url_for_oauth_code
    unless session[:temp_token].blank?
      @token = session[:temp_token]
      @projects_from_friends = no_user_get_friends_projects(@token)
      @friends_projects = @projects_from_friends.first(4)
    end
    @projects = Project.donatable.last(4)
  end

  def fb_callback
    @oauth = Koala::Facebook::OAuth.new(ENV['FB_APP_ID'],"#{ENV['FB_SECRET_KEY']}", "http://compassionforhumanity.org/home/fb_callback")
    if params[:code]
      @cookie = params[:code]
      @token = @oauth.get_access_token(@cookie)
      session[:temp_token] = @token
      redirect_to root_path
    end
  end

end
