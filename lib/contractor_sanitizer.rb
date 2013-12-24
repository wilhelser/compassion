class Contractor::ParameterSanitizer < Devise::ParameterSanitizer
  def sign_up
    default_params.permit(:email, :password, :password_confirmation, :street_address, :city, :state, :zip_code, :name)
  end
end
