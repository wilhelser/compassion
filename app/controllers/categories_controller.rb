class CategoriesController < ApplicationController
  include FriendsProjects
  respond_to :html, :json, :js

  def show
    case params[:id]
    when "all"
      @projects = Project.in_progress.paginate(:page => params[:page], :per_page => 8)
      @page_title = "All Projects"
    when "nearby"
      @projects = Project.in_progress.near([@lat, @long], 50).paginate(:page => params[:page], :per_page => 8)
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
      @projects = @category.projects.in_progress.paginate(:page => params[:page], :per_page => 8)
      @page_title = "#{@category.name}"
    end
    @categories = Category.all
  end
end

