class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_contractor!

  def update
    # For Rails 4
    account_update_params = Contractor::ParameterSanitizer.sanitize(:account_update)

    # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    @contractor = current_contractor
    if @contractor.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      # Sign in the contractor bypassing validation in case his password changed
      sign_in @contractor, :bypass => true
      redirect_to after_update_path_for(@contractor)
    else
      render "edit"
    end
  end
end
