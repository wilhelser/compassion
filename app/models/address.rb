class Address < ActiveRecord::Base
  attr_accessible :addres2, :address, :address_type, :city, :state, :zip_code
  belongs_to :property
end
