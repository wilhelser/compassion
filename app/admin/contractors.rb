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
      f.input :status, :as => :select, :collection => ContractorStatus.all.map{|c| ["#{c.text}", "#{c.text}"]}
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
      f.input :date_of_incorporation, as: :datepicker
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

  # Show
  show do |contractor|
    attributes_table do
      row :id
      row :status
      row :email
      row :name
      row :street_address
      row :city
      row :state
      row :zip_code
      row :coverage_radius
      row :logo
      row :business_legal_name
      row :business_dba_name
      row :date_of_incorporation, as: :datepicker
      row :owner_first_name
      row :owner_last_name
      row :owner_phone
      row :owner_email
      row :mailing_address
      row :mailing_address2
      row :mailing_zip_code
      row :mailing_city
      row :mailing_state
      row :mailing_same
      row :business_tax_id_no
      row :ein
      row :cell_phone
      row :number_of_employees
      row :contractor_license_number
      row :gross_annual_sales_last_year
      row :description
      row :website_url
      row :notify_on_select
      row :notify_on_review
    end
  end

  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end
end
