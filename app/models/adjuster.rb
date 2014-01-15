class Adjuster < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :company, :first_name, :last_name, :phone, :street_address, :city, :state, :zip_code, :fax, :latitude, :longitude, :approved, :cell_phone, :state_licensed_in, :date_license_issued, :license_expiration_date, :license_number, :license
  validates :email, :first_name, :last_name, :phone, :street_address, :city, :state, :zip_code, :presence => true
  has_many :assignments
  has_many :estimates
  has_many :projects, :through => :estimates
  mount_uploader :license, AdjusterLicenseUploader

  geocoded_by :address
  after_validation :geocode

  scope :approved, -> { where(approved: true) }

  def address
    [street_address, city, state, zip_code].compact.join(', ')
  end

  def to_s
    "#{first_name} #{last_name}"
  end

end
