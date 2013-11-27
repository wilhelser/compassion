class AddMoreFieldsToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :business_legal_name, :string
    add_column :contractors, :business_dba_name, :string
    add_column :contractors, :date_of_incorporation, :date
    add_column :contractors, :owner_first_name, :string
    add_column :contractors, :owner_last_name, :string
    add_column :contractors, :owner_phone, :string
    add_column :contractors, :owner_email, :string
    add_column :contractors, :mailing_address, :string
    add_column :contractors, :mailing_address2, :string
    add_column :contractors, :mailing_zip_code, :integer, :limit => 5
    add_column :contractors, :mailing_city, :string
    add_column :contractors, :mailing_state, :string
    add_column :contractors, :mailing_same, :boolean
    add_column :contractors, :business_tax_id_no, :string
    add_column :contractors, :ein, :string
    add_column :contractors, :number_of_employees, :integer
    add_column :contractors, :contractor_license_number, :string
    add_column :contractors, :gross_anual_sales_last_year, :string
  end
end
