class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.integer :project_id, :null => false
      t.string :title, :null => false
      t.text :description

      t.timestamps
    end
  end
end
