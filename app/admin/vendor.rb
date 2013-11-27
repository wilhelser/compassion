ActiveAdmin.register Vendor do
  # Scopes
  scope :all
  scope :verified

  # Filters
  filter :name
  filter :amount
  filter :project
  filter :verified

  # Index
  index do
    selectable_column
    column :name
    column :amount
    column :description
    column :documentation
    column :verified
    actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :amount, :as => :string
      f.input :description
      f.input :verified
    end
    f.actions
  end
end
