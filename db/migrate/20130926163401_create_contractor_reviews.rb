class CreateContractorReviews < ActiveRecord::Migration
  def change
    create_table :contractor_reviews do |t|
      t.integer :contractor_id, :limit => 10, :null => false
      t.integer :user_id, :limit => 10, :null => false
      t.integer :rating, :limit => 1
      t.string :title, :limit => 60, :null => false
      t.text :comments, :null => false
      t.boolean :approved, :default => false
      t.boolean :private, :default => false

      t.timestamps
    end
  end
end
