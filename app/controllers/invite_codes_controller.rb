class InviteCodesController < ApplicationController
  def validate
    if params[:access_code].blank?
      redirect_to :root
    elsif params[:access_code] != 'balls'
      redirect_to :root
    else
      redirect_to new_user_registration_path
    end
  end
end
