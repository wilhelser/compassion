class Adjuster < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :company, :first_name, :last_name, :phone, :street_address, :city, :state, :zip_code, :fax, :latitude, :longitude, :approved, :cell_phone, :state_licensed_in, :date_license_issued, :license_expiration_date, :license_number, :license
  validates :email, :first_name, :last_name, :phone, :street_address, :city, :state, :zip_code, :presence => true
  has_many :assignments
  has_many :estimates
  has_many :projects, :through => :estimates
  mount_uploader :license, AdjusterLicenseUploader
  after_create :send_registration_notification

  geocoded_by :address
  after_validation :geocode

  scope :approved, -> { where(approved: true) }

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
