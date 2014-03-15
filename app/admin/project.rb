ActiveAdmin.register Project do
  actions :all, :except => [:destroy]
  # Scopes
  scope :all
  scope :in_progress
  scope :funded
  scope :inactive

  sidebar "Contractor", only: [:show, :edit], :if => proc{ project.construction_project? } do
    link_to "#{project.contractors.first.name}", admin_contractor_path(project.contractors.first) if project.contractors.any?
  end

  sidebar "Adjuster", only: [:show, :edit], :if => proc{ project.construction_project? } do
    link_to "#{project.adjusters.last.first_name} #{project.adjusters.last.last_name}", admin_adjuster_path(project.adjusters.last) if project.adjusters.any?
  end

  sidebar "Estimates", only: [:show, :edit], :if => proc{ project.construction_project? } do
    ul do
      project.estimates.each do |e|
        li do
          link_to "#{number_to_currency(e.amount)}", e.document.url
        end
      end
    end
  end

  sidebar "Contributions", only: [:show, :edit] do
    ul do
      project.contributions.each do |c|
        li do
          link_to "#{c.amount} - #{c.first_name} #{c.last_name}", admin_contribution_path(c)
        end
      end
    end
  end

  sidebar "Vendors", only: [:show, :edit], :if => proc{ project.needs_vendors? } do
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
  filter :page_title
  filter :city
  filter :state
  filter :zip_code
  filter :contractors
  filter :vendors
  filter :adjusters
  filter :funded
  filter :created_at
  filter :funded_date
  filter :project_deadline
  filter :vendors_paid

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
    column :funded
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
      f.input :vendors_paid
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
      row :project_deadline do
        project.project_deadline
      end
      row :reason_for_deadline
      row :funded
      row :funded_date
      row :status
      row :vendors_paid
    end
  end

  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end
end
