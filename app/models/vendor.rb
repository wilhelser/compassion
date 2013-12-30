class Vendor < ActiveRecord::Base
  attr_accessible :address, :amount, :city, :contact_name, :description, :documentation, :invoice_number, :name, :phone, :project_id, :state, :verified, :zip_code, :due_date, :account_no, :paid
  belongs_to :project
  validates :amount, :name, :address, :city, :state, :zip_code, :phone, :presence => true
  mount_uploader :documentation, VendorUploader
  before_save :strip_commas

  scope :verified, -> { where(verified: true) }
  scope :paid, -> { where(paid: true) }

  def vendor_total
    project.vendors.sum(:amount)
  end

  def strip_commas
    self.amount.gsub!(',', '')
  end

end
