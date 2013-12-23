class ApplicationController < ActionController::Base
  protect_from_forgery

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
