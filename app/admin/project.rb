ActiveAdmin.register Project, :as => "Action" do

  # Scopes
  scope :all
  scope :in_progress
  scope :funded

  sidebar "Contractor", only: [:show, :edit] do
    link_to "#{project.contractors.first.name}", admin_contractor_path(project.contractors.first) if project.contractors.any?
  end

  sidebar "Contributions", only: [:show, :edit] do
    ul do
      project.contributions.each do |c|
        li "#{c.amount} - #{c.first_name} #{c.last_name}"
      end
    end
  end

  sidebar "Vendors", only: [:show, :edit] do
    ul do
      project.vendors.each do |v|
        li link_to "#{v.name} - $ #{v.amount}", admin_vendor_path(v)
      end
    end
  end

  # Filters
  filter :user
  filter :goal_amount
  filter :project_total_contributions
  filter :categories
  filter :status
  filter :page_title
  filter :city
  filter :state
  filter :zip_code
  filter :contractors
  filter :vendors
  filter :adjusters
  filter :created_at
  filter :funded_date
  filter :project_deadline

  # Index
  index do
    selectable_column
    column :id
    column :user
    column :goal_amount
    column :total_contributions
    column :page_title
    column :status
    column :city
    column :state
    column :project_deadline
    default_actions
  end

  # Form
  form do |f|
    f.inputs "Project Details" do
      f.input :goal_amount
      f.input :status
      f.input :approved
      f.input :project_deadline, :as => :date_picker
      f.input :funded
      f.input :funded_date, :as => :date_picker
    end
    f.actions
  end

  # Show
  show do |project|
    attributes_table do
      row :id
      row :categories
      row :goal_amount
      row :page_title
      row :page_message do
        project.page_message.html_safe
      end
      row :user
      row :street_address
      row :city
      row :state
      row :zip_code
      row :project_deadline
      row :reason_for_deadline
      row :funded
      row :funded_date
      row :status
    end
  end
end
