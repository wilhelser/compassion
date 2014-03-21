class CreateBetaRequests < ActiveRecord::Migration
  def change
    create_table :beta_requests do |t|
      t.string :name, limit: 60, null: false
      t.string :email, limit: 60, null: false
      t.boolean :invited, default: false
      t.boolean :registered, default: false
      t.date :invited_date
      t.string :oops

      t.timestamps
    end
  end
end
