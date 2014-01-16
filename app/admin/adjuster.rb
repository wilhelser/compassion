ActiveAdmin.register Adjuster do
  menu :parent => "User Accounts"

  # Scopes
  scope :all
  scope :approved

  # Filters
  filter :email
  filter :company
  filter :first_name
  filter :last_name
  filter :phone
  filter :street_address
  filter :city
  filter :state
  filter :zip_code
  filter :fax
  filter :approved
  filter :cell_phone
  filter :date_license_issued
  filter :license_expiration_date

  # Index
  index do
    selectable_column
    column :id
    column :company
    column :first_name
    column :last_name
    column :city
    column :state
    column :state_licensed_in
    column :approved
    actions
  end

  # Form
  form do |f|
    f.inputs "Adjuster Details" do
      f.input :company
      f.input :first_name
      f.input :last_name
      f.input :phone
      f.input :street_address
      f.input :city
      f.input :state
      f.input :zip_code
      f.input :fax
      f.input :approved
      f.input :cell_phone
      f.input :state_licensed_in
      f.input :date_license_issued, :as => :date_picker
      f.input :license_expiration_date, :as => :date_picker
      f.input :license_number
    end
    f.actions
  end

  # Show
  show do |adjuster|
    attributes_table do
      row :id
      row :email
      row :company
      row :first_name
      row :last_name
      row :phone
      row :street_address
      row :city
      row :state
      row :zip_code
      row :fax
      row :approved
      row :cell_phone
      row :state_licensed_in
      row :date_license_issued
      row :license_expiration_date
      row :license_number
      row :license do
        link_to "License", adjuster.license.url unless adjuster.license.url.blank?
      end
    end
  end
end
