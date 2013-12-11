ActiveAdmin.register Vendor do
  # Scopes
  scope :all
  scope :verified
  scope :paid

  # Filters
  filter :name
  filter :amount
  filter :project
  filter :verified
  filter :paid
  filter :account_no
  filter :due_date

  # Index
  index do
    selectable_column
    column :project
    column :name
    column :amount
    column :due_date
    column "Document" do |vendor|
      unless vendor.documentation.url.nil?
        link_to "Document", vendor.documentation.url
      end
    end
    column :verified
    column :paid
    actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :amount, :as => :string
      f.input :verified
      f.input :address
      f.input :city
      f.input :state
      f.input :zip_code, :as => :string
      f.input :contact_name
      f.input :phone
      f.input :description
      f.input :invoice_number
      f.input :account_no
      f.input :due_date, :as => :date_picker
      f.input :paid
    end
    f.actions
  end

  # Show
  show do |vendor|
    attributes_table do
      row :project
      row :name
      row :amount, :as => :string
      row :verified
      row :address
      row :city
      row :state
      row :zip_code, :as => :string
      row :contact_name
      row :phone
      row :description
      row :invoice_number
      row :account_no
      row :due_date
      row :paid
      row :documentation do
        link_to "Document", vendor.documentation.url unless vendor.documentation.url.nil?
      end
    end
  end
end
