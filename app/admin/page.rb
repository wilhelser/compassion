ActiveAdmin.register Page do

  # Index
  index do
    selectable_column
    column :id
    column :title
    column :title_override
    column :slug
    default_actions
  end

  # Form
  form do |f|
    f.inputs do
      f.input :title
      f.input :title_override
      f.input :content, as: :html_editor
      f.input :slug
    end

    f.actions
  end
end
