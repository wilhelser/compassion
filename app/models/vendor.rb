# == Schema Information
#
# Table name: vendors
#
#  id             :integer          not null, primary key
#  project_id     :integer          not null
#  name           :string(100)      not null
#  amount         :decimal(8, 2)    not null
#  contact_name   :string(100)
#  address        :string(100)
#  city           :string(80)
#  state          :string(2)
#  zip_code       :integer
#  phone          :string(20)
#  invoice_number :string(100)
#  description    :text
#  documentation  :string(255)
#  verified       :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  due_date       :date
#  account_no     :string(255)
#  paid           :boolean          default(FALSE)
#

class Vendor < ActiveRecord::Base
  attr_accessible :address, :amount, :city, :contact_name, :description, :documentation, :invoice_number, :name, :phone, :project_id, :state, :verified, :zip_code, :due_date, :account_no, :paid
  belongs_to :project
  validates :amount, :name, :address, :city, :state, :zip_code, :phone, :presence => true
  validates_numericality_of :amount, :message => "must not contain any punctuation"
  mount_uploader :documentation, VendorUploader

  scope :verified, -> { where(verified: true) }
  scope :paid, -> { where(paid: true) }

  #
  # Total dollar amount of vendor items for project
  #
  # @return [Decimal] total dollar amount of vendor items for project
  def vendor_total
    project.vendors.sum(:amount)
  end
end
