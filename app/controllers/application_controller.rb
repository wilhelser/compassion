class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_request_coordinates

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_sign_up_path_for(resource)
    if resource.is_a?(Contractor)
      dashboard_contractor_path(resource)
    else
      super
    end
  end

  def get_request_coordinates
    if request.location.city.blank?
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

  def after_sign_in_path_for(resource)
    if resource.is_a?(Contractor)
      dashboard_contractor_path(resource)
    elsif resource.is_a?(User)
      dashboard_user_path(resource.id)
    elsif resource.is_a?(Adjuster)
      dashboard_adjuster_path(resource.id)
    else
      super
    end
  end
end
