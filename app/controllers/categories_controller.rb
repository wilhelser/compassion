class CategoriesController < ApplicationController
  include FriendsProjects
  respond_to :html, :json, :js
  before_filter :get_request_coordinates

  def show
    case params[:id]
    when "all"
      @projects = Project.approved.paginate(:page => params[:page], :per_page => 8)
      @page_title = "All Projects"
    when "nearby"
      @projects = Project.approved.near(@ip, 50).paginate(:page => params[:page], :per_page => 8)
      @page_title = "Projects Near: #{@location_city}"
    when "friends"
      if user_signed_in?
        @projects = current_user.get_friends_projects
      else
        @token = session[:temp_token]
        @projects = no_user_get_friends_projects(@token)
      end
      @page_title = "Projects Created by Friends"
      @no_paginate = true
    else
      @category = Category.find(params[:id])
      @projects = @category.projects.approved.paginate(:page => params[:page], :per_page => 8)
      @page_title = "#{@category.name}"
    end
    @categories = Category.all
  end

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

