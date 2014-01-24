class Adjuster::ParameterSanitizer < Devise::ParameterSanitizer

  #
  # Allowed parameters for creating Adjuster account
  #
  def sign_up
    default_params.permit(:email, :password, :password_confirmation, :remember_me, :company, :first_name, :last_name, :phone, :street_address, :city, :state, :zip_code, :fax, :latitude, :longitude, :approved, :cell_phone, :state_licensed_in, :date_license_issued, :license_expiration_date, :license_number, :license)
  end

  #
  # Allowed parameters for updating Adjuster account
  #
  def account_update
    default_params.permit(:email, :password, :password_confirmation, :remember_me, :company, :first_name, :last_name, :phone, :street_address, :city, :state, :zip_code, :fax, :latitude, :longitude, :approved, :cell_phone, :state_licensed_in, :date_license_issued, :license_expiration_date, :license_number, :license)
  end
end
