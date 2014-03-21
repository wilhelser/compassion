class InviteCodesController < ApplicationController
  def validate
    if params[:access_code].blank?
      redirect_to :root, flash: { notice: "Invalid invite code."}
    elsif params[:access_code] != 'create!907'
      redirect_to :root, flash: { notice: "Invalid invite code."}
    else
      redirect_to new_user_registration_path
    end
  end
end
