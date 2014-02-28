ActiveAdmin.register Contractor do
  menu :parent => "User Accounts"

  # Scopes
  scope :all
  scope :approved
  scope :pending
  scope :not_submitted

  # Form
  form do |f|
    f.inputs "Contractor Details" do
      f.input :email
      f.input :name
      f.input :street_address
      f.input :city
      f.input :state
      f.input :zip_code
      f.input :coverage_radius
      f.input :logo
      f.input :business_legal_name
      f.input :business_dba_name
      f.input :date_of_incorporation
      f.input :owner_first_name
      f.input :owner_last_name
      f.input :owner_phone
      f.input :owner_email
      f.input :mailing_address
      f.input :mailing_address2
      f.input :mailing_zip_code
      f.input :mailing_city
      f.input :mailing_state
      f.input :mailing_same
      f.input :business_tax_id_no
      f.input :ein
      f.input :cell_phone
      f.input :number_of_employees
      f.input :contractor_license_number
      f.input :gross_annual_sales_last_year
      f.input :description
      f.input :website_url
      f.input :notify_on_select
      f.input :notify_on_review
    end
    f.actions
  end


  index do
    selectable_column
    column :name
    column :city
    column :state
    column :created_at
    actions
  end
end
