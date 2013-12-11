ActiveAdmin.register Page do
  form do |f|
    f.inputs do
      f.input :title
      f.input :content, as: :html_editor
      f.input :slug
    end

    f.buttons
  end
end
