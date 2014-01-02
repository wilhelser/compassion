class UsersController < InheritedResources::Base
  before_filter :authenticate_user!, :only => [:edit, :dashboard]

  def show
    @user = User.find(params[:id])
    @page_title = "#{@user.name} - #{@user.city}, #{@user.state}"
    @projects = @user.projects
  end

  def edit
    @user = current_user
  end

  def dashboard
    @user = current_user
    session[:temp_token] = ""
    @projects = @user.projects
    @page_title = "Your Dashboard"
  end

end
