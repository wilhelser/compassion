class InviteCodesController < ApplicationController
  def validate
    if params[:access_code].blank?
      redirect_to :root, flash: { notice: "Invalid invite code."}
    elsif params[:access_code] != 'create!907'
      redirect_to :root, flash: { notice: "Invalid invite code."}
    else
      set_tracking_cookie
      redirect_to new_user_registration_path
    end
  end

  private
  def set_tracking_cookie
    cookies.permanent[:beta_access] = true unless cookies[:beta_access]
  end
end
