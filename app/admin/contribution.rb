ActiveAdmin.register Contribution do
  # Filters
  filter :project
  filter :amount
  filter :private
  filter :first_name
  filter :last_name
  filter :address
  filter :city
  filter :state
  filter :email

  # Index
  index do
    selectable_column
    column :id
    column :project
    column :private
    column :first_name
    column :last_name
    default_actions
  end

  # Show
  show do |contribution|
    attributes_table do
      row :id
      row :project
      row :amount
      row :first_name
      row :last_name
      row :email
      row "Type" do
        contribution.project.categories.each do |c|
          link_to "#{c.name}", admin_category_path(c)
        end
      end
      row :address
      row :address_2
      row :city
      row :state
      row :zip_code
      row :private
    end
  end
end
