class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  helper FilepickerRails::Engine.helpers

  #
  # Custom parameter sanitizer for Devise. Users, contractors
  # and vendors
  #
  def devise_parameter_sanitizer
    if resource_class == Contractor
      Contractor::ParameterSanitizer.new(Contractor, :contractor, params)
    elsif resource_class == Adjuster
      Adjuster::ParameterSanitizer.new(Adjuster, :adjuster, params)
    else
      super
    end
  end

  #
  # Sets the after_sign_out_path_for users, contractors and adjusters
  # to that resources root_path
  # @param  resource_or_scope [Object] resource or scope ( user,
  # adjuster or contractor )
  #
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  #
  # Sets the after_sign_up_path_for users, contractors and adjusters
  # to that resources root_path
  # Contractors go to their dashboard, everyone else to their root_url
  # @param  resource_or_scope [Object] resource or scope ( user,
  # adjuster or contractor )
  #
  def after_sign_up_path_for(resource)
    if resource.is_a?(Contractor)
      dashboard_contractor_path(resource)
    else
      super
    end
  end

  def after_update_path_for(resource)
    if resource.is_a?(Contractor)
      edit_profile_contractor_path(resource)
    elsif resource.is_a?(Adjuster)
      dashboard_adjuster_path(resource.id)
    else
      super
    end
  end

  #
  # Sets the after_sign_in_path for users, contractors, adjusters to
  # their dashboards
  # @param  resource [Object] resource ( user, contractor, adjuster )
  #
  def after_sign_in_path_for(resource)
    if resource.is_a?(Contractor)
      dashboard_contractor_path(resource.id)
    elsif resource.is_a?(User)
      dashboard_user_path(resource.id)
    elsif resource.is_a?(Adjuster)
      dashboard_adjuster_path(resource.id)
    else
      super
    end
  end
end
