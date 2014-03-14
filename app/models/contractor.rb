# == Schema Information
#
# Table name: contractors
#
#  id                           :integer          not null, primary key
#  name                         :string(255)      not null
#  street_address               :string(255)      not null
#  city                         :string(255)      not null
#  state                        :string(255)      not null
#  zip_code                     :integer          not null
#  latitude                     :float
#  longitude                    :float
#  coverage_radius              :integer          default(25)
#  logo                         :string(255)
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  business_legal_name          :string(255)
#  business_dba_name            :string(255)
#  date_of_incorporation        :date
#  owner_first_name             :string(255)
#  owner_last_name              :string(255)
#  owner_phone                  :string(255)
#  owner_email                  :string(255)
#  mailing_address              :string(255)
#  mailing_address2             :string(255)
#  mailing_zip_code             :integer
#  mailing_city                 :string(255)
#  mailing_state                :string(255)
#  mailing_same                 :boolean
#  business_tax_id_no           :string(255)
#  ein                          :string(255)
#  number_of_employees          :integer
#  contractor_license_number    :string(255)
#  gross_annual_sales_last_year :string(255)
#  description                  :text
#  email                        :string(255)      default(""), not null
#  encrypted_password           :string(255)      default(""), not null
#  reset_password_token         :string(255)
#  reset_password_sent_at       :datetime
#  remember_created_at          :datetime
#  sign_in_count                :integer          default(0)
#  current_sign_in_at           :datetime
#  last_sign_in_at              :datetime
#  current_sign_in_ip           :string(255)
#  last_sign_in_ip              :string(255)
#  password_salt                :string(255)
#  confirmation_token           :string(255)
#  confirmed_at                 :datetime
#  confirmation_sent_at         :datetime
#  unconfirmed_email            :string(255)
#  authentication_token         :string(255)
#  status                       :string(255)      default("Not Submitted"), not null
#  terms                        :boolean
#  preferred                    :boolean          default(FALSE)
#  website_url                  :string(255)
#  slug                         :string(255)
#  gmaps                        :boolean
#  notify_on_select             :boolean          default(TRUE)
#  notify_on_review             :boolean          default(TRUE)
#  cell_phone                   :string(30)
#

class Contractor < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_name, :against => :name
  acts_as_gmappable
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :street_address, :city, :state, :zip_code, :name, :street_address, :city, :coverage_radius, :latitude, :logo, :longitude, :name, :state, :zip_code, :business_legal_name, :business_dba_name, :date_of_incorporation, :owner_first_name, :owner_last_name, :owner_phone, :owner_email, :mailing_address, :mailing_address2, :mailing_zip_code, :mailing_city, :mailing_state, :mailing_same, :business_tax_id_no, :ein, :cell_phone, :number_of_employees, :contractor_license_number, :gross_annual_sales_last_year, :trade_ids, :references_attributes, :description, :addresses_attributes, :email, :password, :password_confirmation, :remember_me, :terms, :website_url, :slug, :gmaps, :notify_on_select, :notify_on_review, :cell_phone
  validates_acceptance_of :terms, :accept => true, :message => "You must agree to the terms", :on => :create
  validates_uniqueness_of :slug
  validates :email, :password, :street_address, :city, :state, :zip_code, :name, :owner_phone, presence: true
  has_many :contractor_selections
  has_many :contractor_reviews, dependent: :destroy
  has_many :projects, :through => :contractor_selections
  has_and_belongs_to_many :trades
  has_many :galleries, dependent: :destroy
  after_create :send_registration_notification

  geocoded_by :address
  # after_create :geocode

  scope :pending, -> { where(status: 'Pending') }
  scope :approved, -> { where(status: 'Approved') }
  scope :not_submitted, -> { where(status: 'Not Submitted') }

  #
  # Full address of contractor
  #
  # @return [String] full address pulled from all address fields
  def address
    [street_address, city, state, zip_code].compact.join(', ')
  end

  #
  # Contractor address for mapping on Google maps
  #
  # @return [String] Contractor street_address and city concatenated
  def gmaps4rails_address
    "#{self.street_address}, #{self.city}"
  end

  #
  # Whether contractor is approved or not
  #
  # @return [Boolean] true if contractor is approved
  def approved
    self.status == "Approved"
  end

  #
  # Whether contractor has any reviews
  #
  # @return [Boolean] true if contractor has reviews
  def has_reviews?
    self.contractor_reviews.size > 0
  end

  #
  # If contractor can edit a gallery
  # @param  gallery [Object] gallery object
  #
  # @return [Boolean] true if contractor can manage the gallery
  def can_manage_gallery?(gallery)
    @gallery = gallery
    if @gallery.contractor_id == self.id
      return true
    else
      return false
    end
  end

  #
  # Number of active projects for contractor
  #
  # @return [Integer] number of projects contractor has in progress
  def active_projects
    self.projects.in_progress
  end

  #
  # Number of completed projects for contractor
  #
  # @return [Integer] number of projects contractor has completed
  def completed_projects
    self.projects.complete
  end

  #
  # Number of reviews contractor has
  #
  # @return [Integer] number of contractor reviews
  def review_count
    self.contractor_reviews.size
  end

  #
  # Total stars contractor has received in reviews
  #
  # @return [Integer] total number of stars contractor has received
  def total_stars
    self.contractor_reviews.sum(:rating)
  end

  #
  # Contractor star rating
  #
  # @return [Integer] contractor average star rating for display on profile
  def rating
    self.has_reviews? ? self.total_stars / self.review_count : 0
  end

  #
  # Emails Compassion when new contractor registers on site
  #
  def send_registration_notification
    ContractorMailer.contractor_signup_notification(self).deliver
  end

end
