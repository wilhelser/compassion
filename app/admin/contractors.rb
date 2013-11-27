ActiveAdmin.register Contractor do
  menu :parent => "User Accounts"

  # Scopes
  scope :all
  scope :approved
  scope :pending
  scope :not_submitted



  index do
    selectable_columns
    column :name
    column :city
    column :state
    column :created_at
    actions
  end
end
