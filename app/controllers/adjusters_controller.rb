class AdjustersController < ApplicationController
  before_filter :authenticate_adjuster!
  before_filter :get_adjuster
  respond_to :html, :js, :json

  def dashboard
    @page_title = "#{@adjuster.first_name} #{@adjuster.last_name} - Dashboard"
    @assignments = @adjuster.assignments
    @estimates = @adjuster.estimates
  end

  def update
    if params[:adjuster][:password].blank?
      params[:adjuster].delete(:password)
      params[:adjuster].delete(:password_confirmation)
    end
    if @adjuster.update_attributes(params[:adjuster])
      respond_with @adjuster
    else
      respond_with @adjuster.errors.full_messages
    end
  end

  def decline_assignment
    @assignment = Assignment.find(params[:assignment_id])
    @project = Project.find(@assignment.project_id)
  end

  private
  def get_adjuster
    @adjuster = current_adjuster
  end

  private
  def adjuster_params
    params.require(:email, :first_name, :last_name, :phone, :street_address, :city, :state, :zip_code).permit(:remember_me, :company, :fax, :latitude, :longitude, :approved, :cell_phone, :state_licensed_in, :date_license_issued, :license_expiration_date, :license_number, :license)
  end
end
