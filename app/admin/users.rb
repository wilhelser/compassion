ActiveAdmin.register User do
  menu :parent => "User Accounts"

  index do
    column :email
    column :created_at
    column :name
    column :username
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :uid
      row :provider
      row :username
      row :slug
      row :city
      row :state
      row :zip_code
      row :current_sign_in_ip
      row :last_sign_in_ip
    end
  end

end
