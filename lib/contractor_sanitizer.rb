class Contractor::ParameterSanitizer < Devise::ParameterSanitizer

  #
  # Allowed parameters for creating Contractor account
  #
  def sign_up
    default_params.permit(:email, :password, :password_confirmation, :street_address, :city, :state, :zip_code, :name, :owner_phone, :cell_phone, :latitude, :longitude, :slug, :terms, :coverage_radius)
  end

  #
  # Allowed parameters for updating Contractor account
  #
  def account_update
    default_params.permit(:email, :password, :password_confirmation, :street_address, :city, :state, :zip_code, :name, :owner_phone, :cell_phone, :latitude, :longitude, :coverage_radius, :logo, :business_legal_name, :business_dba_name, :date_of_incorporation, :owner_first_name, :owner_last_name, :owner_phone, :owner_email, :mailing_address, :mailing_address2, :mailing_zip_code, :mailing_city, :mailing_state, :mailing_same, :business_tax_id_no, :ein, :number_of_employees, :contractor_license_number, :gross_annual_sales_last_year, :description, :email, :status, :terms, :preferred, :website_url, :slug, :gmaps, :notify_on_select, :notify_on_review, :cell_phone, :trade_ids, :coverage_radius)
  end
end
