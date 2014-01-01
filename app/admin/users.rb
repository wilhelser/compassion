ActiveAdmin.register User do
  menu :parent => "User Accounts"
  before_filter :only => [:show] do
    @user = User.friendly.find(params[:id])
  end

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
    end
  end

end
