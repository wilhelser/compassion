class AddLicenseFieldsToAdjusters < ActiveRecord::Migration
  def change
    add_column :adjusters, :cell_phone, :string
    add_column :adjusters, :state_licensed_in, :text
    add_column :adjusters, :license_number, :string
    add_column :adjusters, :date_license_issued, :date
    add_column :adjusters, :license_expiration_date, :date
    add_column :adjusters, :license, :string
  end
end
