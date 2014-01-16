class Contractor < ActiveRecord::Base
  require 'textacular/searchable'
  extend Searchable(:name, :city, :state, :zip_code)
  acts_as_gmappable
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :street_address, :city, :state, :zip_code, :name, :street_address, :city, :coverage_radius, :latitude, :logo, :longitude, :name, :state, :zip_code, :business_legal_name, :business_dba_name, :date_of_incorporation, :owner_first_name, :owner_last_name, :owner_phone, :owner_email, :mailing_address, :mailing_address2, :mailing_zip_code, :mailing_city, :mailing_state, :mailing_same, :business_tax_id_no, :ein, :number_of_employees, :contractor_license_number, :gross_annual_sales_last_year, :trade_ids, :references_attributes, :description, :addresses_attributes, :email, :password, :password_confirmation, :remember_me, :terms, :website_url, :slug, :gmaps, :notify_on_select, :notify_on_review
  validates_acceptance_of :terms, :accept => true, :message => "You must agree to the terms", :on => :create
  validates_uniqueness_of :slug
  has_many :contractor_selections
  has_many :contractor_reviews, dependent: :destroy
  has_many :projects, :through => :contractor_selections
  has_and_belongs_to_many :trades
  has_many :galleries, dependent: :destroy
  has_many :references, :dependent => :destroy
  has_many :addresses, :dependent => :destroy
  accepts_nested_attributes_for :references, :allow_destroy => true
  accepts_nested_attributes_for :addresses, :allow_destroy => true
  after_create :send_registration_notification

  geocoded_by :address
  # after_create :geocode

  scope :pending, -> { where(status: 'Pending') }
  scope :approved, -> { where(status: 'Approved') }
  scope :not_submitted, -> { where(status: 'Not Submitted') }

  def address
    [street_address, city, state, zip_code].compact.join(', ')
  end

  def gmaps4rails_address
    "#{self.street_address}, #{self.city}"
  end

  def approved
    self.status == "Approved"
  end

  def has_reviews?
    self.contractor_reviews.size > 0
  end

  def can_manage_gallery?(gallery)
    @gallery = gallery
    if @gallery.contractor_id == self.id
      return true
    else
      return false
    end
  end

  def active_projects
    self.projects.in_progress
  end

  def completed_projects
    self.projects.complete
  end

  def review_count
    self.contractor_reviews.size
  end

  def total_stars
    self.contractor_reviews.sum(:rating)
  end

  def rating
    self.has_reviews? ? self.total_stars / self.review_count : 0
  end

  def business_references
    self.references.where(:reference_type => "Business")
  end

  def customer_references
    self.references.where(:reference_type => "Customer")
  end

  def send_registration_notification
    ContractorMailer.contractor_signup_notification(self).deliver
  end

end
