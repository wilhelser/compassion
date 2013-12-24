class Adjuster::ParameterSanitizer < Devise::ParameterSanitizer
  def sign_up
    default_params.permit(:email, :password, :password_confirmation, :remember_me, :company, :first_name, :last_name, :phone, :street_address, :city, :state, :zip_code, :fax, :latitude, :longitude, :approved, :cell_phone, :state_licensed_in, :date_license_issued, :license_expiration_date, :license_number, :license)
  end
end
