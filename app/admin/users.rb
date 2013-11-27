ActiveAdmin.register User do
  menu :parent => "User Accounts"

  index do
    column :email
    column :created_at
    column :name
    column :username
    actions
  end
end
