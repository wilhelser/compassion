class HomeController < ApplicationController
  include FriendsProjects
  layout Proc.new { |controller| controller.request.xhr?? false : 'application' }
  respond_to :html, :json, :js
  # before_filter :get_request_coordinates, only: [:index@import "☄";]
  def index
    @page_title = "Changing the World Together"
    @categories = Category.all
    @ip = request.remote_ip
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

  def fb_callback
    @oauth = Koala::Facebook::OAuth.new(ENV['FB_APP_ID'],"#{ENV['FB_SECRET_KEY']}", "http://compassionforhumanity.org/home/fb_callback")
    if params[:code]
      @cookie = params[:code]
      @token = @oauth.get_access_token(@cookie)
      session[:temp_token] = @token
      redirect_to root_path
    end
  end

  def get_request_coordinates
    Rails.logger.info "#{request.location}"
    if request.location.nil?
      @location_city = "Denton"
    else
      @location_city = request.location.city
    end
    if request.location.latitude.blank?
      @lat = 33.2201
    else
      @lat = request.location.latitude
    end
    if request.location.longitude.blank?
      @long = -97.1502
    else
      @long = request.location.longitude
    end
    if request.location.country_code.blank?
      @location_country = "US"
    else
      @location_country = request.location.country_code
    end
  end

end
