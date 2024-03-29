ActiveAdmin.register Category do
  filter :name

  index do
    column :name
    column :position
    column :slug
    actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :position, :as => :select, :collection => 1.upto(Category.all.size)
      f.input :description
    end
    f.actions
  end

  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end

end
