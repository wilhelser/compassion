class Contractor::ParameterSanitizer < Devise::ParameterSanitizer

  #
  # Allowed parameters for creating Contractor account
  #
  def sign_up
    default_params.permit(:email, :password, :password_confirmation, :street_address, :city, :state, :zip_code, :name, :owner_phone)
  end

  #
  # Allowed parameters for updating Adjuster account
  #
  def account_update
    default_params.permit(:street_address, :city, :state, :zip_code, :name, :street_address, :city, :coverage_radius, :latitude, :logo, :longitude, :name, :state, :zip_code, :business_legal_name, :business_dba_name, :date_of_incorporation, :owner_first_name, :owner_last_name, :owner_phone, :owner_email, :mailing_address, :mailing_address2, :mailing_zip_code, :mailing_city, :mailing_state, :mailing_same, :business_tax_id_no, :ein, :number_of_employees, :contractor_license_number, :cell_phone, :gross_annual_sales_last_year, :trade_ids, :references_attributes, :description, :addresses_attributes, :email, :password, :password_confirmation, :remember_me, :terms, :website_url, :slug, :gmaps, :notify_on_select, :notify_on_review, :cell_phone)
  end
end
