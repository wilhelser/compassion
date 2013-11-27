ActiveAdmin.register Donation do
  index do
    column :amount
    column :name
    column :created_at
    column :email
    actions
  end
end
