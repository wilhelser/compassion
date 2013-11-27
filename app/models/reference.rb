class Reference < ActiveRecord::Base
  attr_accessible :address, :address2, :city, :company_name, :contact_first_name, :contact_last_name, :contractor_id, :email, :phone_number, :reference_type, :state, :time_affiliated, :zip_code

  belongs_to :contractor, :dependent => :destroy
end
