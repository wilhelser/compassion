ActiveAdmin.register Estimate do

  # Filters
  filter :project
  filter :adjuster
  filter :amount
  filter :created_at

  # Form
  form do |f|
    f.inputs "Estimate Details" do
      f.input :adjuster
      f.input :project
      f.input :amount, :as => :string
      f.input :description
    end
    f.actions
  end

  # Index
  index do
    selectable_column
    column :id
    column :adjuster
    column :project
    column :amount do |estimate|
      number_to_currency(estimate.amount)
    end
    column :description
    column "Document" do |estimate|
      link_to "Estimate", estimate.document.url unless estimate.document.url.nil?
    end
    default_actions
  end

  # Show
  show do |estimate|
    attributes_table do
      row :id
      row :adjuster
      row :project
      row :amount do
        number_to_currency(estimate.amount)
      end
      row :description
      row :document do
        link_to "Estimate", estimate.document.url unless estimate.document.url.nil?
      end
    end
  end
end
