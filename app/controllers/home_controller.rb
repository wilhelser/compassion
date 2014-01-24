class HomeController < ApplicationController
  include FriendsProjects
  layout Proc.new { |controller| controller.request.xhr?? false : 'application' }
  respond_to :html, :json, :js
  before_filter :get_request_coordinates, only: [:index]

  def index
    @page_title = "Changing the World Together"
    @categories = Category.all
    @projects_near_me = Project.approved.near(@ip, 50).limit(4).includes(:user)
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
    @projects = Project.approved.last(4)
  end

  #
  # Response to FB callback. Pulls authentication token from code
  # sets the token to a session variable and redirects to the
  # Home page
  #
  def fb_callback
    @oauth = Koala::Facebook::OAuth.new(ENV['FB_APP_ID'],"#{ENV['FB_SECRET_KEY']}", "http://compassionforhumanity.org/home/fb_callback")
    if params[:code]
      @cookie = params[:code]
      @token = @oauth.get_access_token(@cookie)
      session[:temp_token] = @token
      redirect_to root_path
    end
  end

  #
  # Parses coordinates from request parameters. First checks for a
  # request.location param then falls back to IP based check
  #
  # @return [type] [description]
  def get_request_coordinates
    if request.location.nil?
      @ip = request.remote_ip
      @location_city = "Denton"
    else
      @ip = request.ip
      @location_city = request.location.city
    end
    if request.location.country_code.blank?
      @location_country = "US"
    else
      @location_country = request.location.country_code
    end
  end
end
