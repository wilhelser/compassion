ActiveAdmin.register BetaRequest do
  permit_params :name, :email, :oops, :invited

  # Scopes
  scope :all
  scope :invited

  # Index
  index do
    selectable_column
    column :id
    column :name
    column :email
    column :invited
    default_actions
  end

  # Form
  form do |f|
    f.inputs "Request Details" do
      f.input :name
      f.input :email
      f.input :invited
    end
    f.actions
  end

  # Show
  show do |beta_request|
    attributes_table do
      row :id
      row :created_at do
        beta_request.created_at
      end
      row :name
      row :email
      row :invited
      row :invited_date do
        beta_request.invited_date
      end
      row :registered
    end
  end

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

end
