ActiveAdmin.register Category do
  filter :name

  index do
    column :name
    column :order
    column :slug
    actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :order, :as => :select, :collection => 1.upto(Category.all.size)
      f.input :description
    end
    f.actions
  end

end
