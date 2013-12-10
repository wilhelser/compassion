class Vendor < ActiveRecord::Base
  attr_accessible :address, :amount, :city, :contact_name, :description, :documentation, :invoice_number, :name, :phone, :project_id, :state, :verified, :zip_code
  belongs_to :project
  validates :amount, :name, :presence => true
  mount_uploader :documentation, VendorUploader

  scope :verified, where(:verified => true)

  def vendor_total
    project.vendors.sum(:amount)
  end

end
