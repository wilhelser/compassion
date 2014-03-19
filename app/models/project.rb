# == Schema Information
#
# Table name: projects
#
#  id                      :integer          not null, primary key
#  user_id                 :integer
#  goal_amount             :decimal(, )
#  page_title              :string(60)       not null
#  zip_code                :integer          not null
#  page_message            :text             not null
#  slug                    :string(255)
#  approved                :boolean          default(TRUE), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  featured_image          :string(255)
#  featured_video          :string(255)
#  project_category_id     :integer
#  status                  :string(255)      default("In Progress")
#  street_address          :string(255)
#  city                    :string(255)
#  state                   :string(255)
#  latitude                :float
#  longitude               :float
#  notify_on_donate        :boolean
#  private                 :boolean          default(FALSE)
#  has_reviewed_contractor :boolean          default(FALSE)
#  backer_count            :integer          default(0)
#  project_deadline        :date
#  reason_for_deadline     :text
#  funded                  :boolean          default(FALSE)
#  funded_date             :date
#  funded_confirm          :boolean          default(FALSE)
#  campaign_ended          :boolean          default(FALSE)
#  key                     :string(255)
#  campaign_ended_date     :date
#  campaign_extended_date  :date
#  vendors_paid            :boolean          default(FALSE)
#

class Project < ActiveRecord::Base
  include Koala
  extend FriendlyId
  include AutoHtml
  include ProjectMethods
  include ImageMethods
  friendly_id :page_title, use: :slugged
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :trades
  attr_accessible :approved, :goal_amount, :page_message, :page_title, :slug, :zip_code, :featured_image, :featured_video, :category_ids, :street_address, :city, :state, :latitude, :longitude, :user_id, :notify_on_donate, :private, :contractor_selection_attributes, :has_reviewed_contractor, :backer_count, :project_deadline, :reason_for_deadline, :funded, :funded_date, :galleries_attributes, :contributions_attributes, :funded_confirm, :campaign_ended, :key, :trade_ids, :status, :campaign_ended_date, :campaign_extended_date, :vendors_paid
  validates :page_message, :page_title, :zip_code, :street_address, :city, :state, :category_ids, :slug, presence: true
  validates_uniqueness_of :slug
  validates_presence_of :featured_image, :if => lambda { self.featured_video.blank? }
  validates_presence_of :featured_video, :if => lambda { self.featured_image.blank? }
  belongs_to :user, touch: true
  has_many :updates, dependent: :destroy
  has_many :contributions
  has_many :galleries, dependent: :destroy
  has_many :contractor_selections
  has_many :contractors, :through => :contractor_selections
  has_many :vendors
  has_one :assignment
  has_one :adjuster, through: :assignment
  has_many :estimates
  geocoded_by :address
  after_validation :geocode
  accepts_nested_attributes_for :galleries
  accepts_nested_attributes_for :contributions
  before_save :set_key, :if => :featured_image_changed?
  before_save :set_video_key, :if => lambda { self.featured_video.present? }
  before_create :slugify
  after_create :post_to_compassion
  after_create :send_new_project_email
  after_create :set_to_unapproved, :if => lambda { self.category_ids.include?(4) }

  scope :approved, -> { where(approved: true) }
  scope :in_progress, -> { where(status: 'In Progress') }
  scope :inactive, -> { where(approved: false) }
  scope :funded, -> { where(funded: true) }
  scope :complete, -> { where(campaign_ended: true) }
  scope :donatable, -> { where('goal_amount > ?', 0) }
  scope :extended, -> { where('campaign_extended_date != ?', nil) }

  def slugify

  end

  #
  # Builds full address from project address fields
  #
  # @return [String] full project address for display on site
  def address
    [street_address, city, state, zip_code].compact.join(', ')
  end

  #
  # Sets a construction project to unapproved pending upload
  # of estimate
  #
  def set_to_unapproved
    self.update_attribute('approved', false)
    notify_empty_contractors
  end

  def no_paragraph_page_message
    @body = self.page_message.gsub('<br>', '\r\n')
    return clean_and_strip(@body)
  end

  def clean_and_strip(string)
    decoder = HTMLEntities.new
    @string = string
    @body = decoder.decode(@string)
    return ActionView::Base.full_sanitizer.sanitize(@body)
  end

  #
  # Strips HTML from page_message for truncation and display
  # on small project view
  #
  # @return [String] sanitized page_message
  def stripped_content
    clean_and_strip(self.page_message)
  end

  #
  # Pulls thumbnail image from YouTube to display as image
  # on small project view and sets the returned URL as project
  # key
  #
  # @return [String] URL to YouTube thumbnail image
  def set_video_key
    video_link = self.featured_video
    if video_link.include?('youtu.be')
      video_id = video_link.gsub('http://youtu.be/', '')
    elsif video_link.include?('youtube.com')
      video_id = video_link.gsub('http://youtube.com/', '')
    end
    video_key = "http://img.youtube.com/vi/#{video_id}/0.jpg"
    self.key = video_key
  end

  #
  # Determines whether Action is a construction project or not
  #
  # @return [Boolean] true if Action is in the Construction category ( 8 )
  def construction_project?
    self.category_ids.include?(4)
  end

  #
  # Determines whether Action needs additional vendors to cover
  # excess funds
  #
  # @return [Boolean] true if Action has excess funds and isn't complete
  def needs_more_vendors
    if self.construction_project? || self.complete?
      false
    else
      self.has_excess_funds ? true :false
    end
  end

  #
  # Get's the actual image URL for a featured image uploaded through
  # Ink Filepicker and set's it as the project's key
  #
  # @return [String] set's the project's key
  def set_key
    unless featured_image.blank?
      @image = self.featured_image
      @key = get_s3_url(@image)
      self.key = @key
    end
  end

  #
  # Selects approved contractors within 200 miles of Action
  #
  # @return [Hash] [contractors within 200 miles]
  def nearby_contractors
    Contractor.approved.near(self, 200)
  end

  #
  # Builds a full URL for a project's featured image fron the project's key
  # Used for small thumbnails
  #
  # @return [ String ] full featured_image URL
  def image_url
    "https://s3.amazonaws.com/c4humanity/#{self.key}"
  end

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end

  #
  # Determines if a project has any galleries
  #
  # @return [Boolean] [true if project has galleries]
  def has_galleries?
    self.galleries.size > 0
  end

  #
  # Sends welcome email to user after creation of project
  #
  def send_new_project_email
    ProjectMailer.new_project_user_email(self.user, self).deliver
  end

  #
  # Set's a variable for use in full links
  # This should probably be extracted into the application controller
  # for global availability
  #
  # @return [String] Base site URL
  def site_root
    if Rails.env == "development"
      "http://mnp.dev/"
    else
      "http://compassionforhumanity.org/"
    end
  end

  #
  # Project total contributions
  #
  # @return [Decimal] sum total of project's contributions
  def total_contributions
    unless self.contributions.nil?
      self.contributions.sum(:amount)
    else
      0.00
    end
  end

  #
  # Parameter for displaying project in dropdowns in admin panel
  #
  # @return [String] project's page title
  def to_s
    page_title
  end

  #
  # Determin if project has a deadline set
  #
  # @return [Boolean] true if project has a deadline set
  def has_deadline?
    self.project_deadline != nil
  end

  #
  # Determine if a project has been ended and marked complete
  #
  # @return [Boolean] true if project has been ended
  def complete?
    self.campaign_ended
  end

  #
  # Determine whether project has an estimate(s)
  #
  # @return [Boolean] true if project has any associated estimates
  def has_estimate?
    self.estimates.any?
  end

  #
  # Determine whether project has an associated YouTube video
  #
  # @return [Boolean] true if project has value in featured_video column
  def has_video?
    self.featured_video.present? ? true : false
  end

  #
  # Helper for generating HTML to display featured video
  #
  auto_html_for :featured_video do
    html_escape
    image
    youtube(:width => 770, :height => 300)
    vimeo(:width => 770, :height => 300)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  #
  # Determine whether project needs a contractor ( construction project )
  #
  # @return [Boolean] true if project is contruction project
  def needs_contractor
    self.category_ids.include?(4)
  end

  #
  # Determines if project needs vendors ( not construction project )
  #
  # @return [Boolean] true unless project is construction project
  def needs_vendors?
    true unless self.category_ids.include?(4)
  end

  #
  # Determine whether project has an assigned contractor
  #
  # @return [Boolean] true if project has an assigned contractor
  def has_contractor
    if self.contractors.size == 0
      false
    else
      true
    end
  end

  #
  # Generates a qrcode for display on the project print flyer
  #
  # @return [String] generated URL for project's qrcode
  def qrcode
    "#{self.long_link}.png"
  end

  #
  # Updates backer count after a contribution is made
  # probable should add a counter cache for this
  #
  def update_backer_count
    self.update_attribute('backer_count', self.contributions.length)
  end

  #
  # Generates full link to project
  #
  # @return [String] full URL to project
  def long_link
    "#{site_root}projects/#{self.slug}"
  end

  #
  # Project's public contributions
  #
  # @return [Hash] all public contributions to project
  def public_contributions
    self.contributions.public
  end

  #
  # Whether or not a project can accept donations
  # if not, Donate button will not appear on project page
  #
  # @return [Boolean] true if project has a goal_amount set
  def can_accept_donations
    self.goal_amount > 0
  end

  #
  # Number of backers. Based off contributions
  # should probably implement a counter cache
  #
  # @return [Integer] total number of project's contributions
  def backer_count
    self.contributions.size
  end

  #
  # Recent contributions for display in project show sidebar
  #
  # @return [Hash] last 10 contributions
  def recent_contributions
    self.contributions.last(10)
  end

  #
  # Percentage of project's goal_amount that is funded
  #
  # @return [Float] percentage of goal amount funded
  def percent_funded
    if self.goal_amount > 0
      self.total_contributions.to_f / self.goal_amount.to_f * 100.0
    else
      0.00
    end
  end

  #
  # Access token to allow app to publish on Compassion's FB page
  #
  def compassion_access_token
    "231408540317089|m8oArqgfDqwmu1yS38QjXDUtVvQ"
    # "289217204546185|SiM5nY_waJtkr9JjpeLBRluESNc" DEVELOPMENT
  end

  #
  # Access token to allow app to publish updates to Compassion's FB page
  #
  def compassion_page_access_token
    "CAADSdvZCX9aEBAOCEjCwzQqyIoaDCetcSRZA9RDXOh7ZAbVQxtP9uOFgCHjQddMytI4wpK3ZAR4BhtxxVGZCcU9gZAO10lOAma2KZBCXX9P4tCZA2pYYZAk2UukYWUQLkWsNnzluDpN44iwlfcWltbmLon01o4Kjw9pGw2GW3bbpBbtmno5VZAdZCrJ"
  end

  #
  # Page ID of Compassion's FB page
  #
  # @return [Integer] page id for Compassion's FB page
  def compassion_fb_page_id
    "583630311678418"
  end

  #
  # Posts project details to Compassion's FB page after project creation
  #
  def post_to_compassion
    unless self.private?
      @graph = Koala::Facebook::API.new(compassion_page_access_token)
      @graph.put_wall_post("New Action posted!", { :name => "#{self.page_title}", :description => "#{self.stripped_content}", :link => "http://compassionforhumanity.org/projects/#{self.slug}"})
    end
  end

  #
  # Determine if project contributions exceed goal amount
  #
  # @return [Boolean] true if total contributions are greater than goal amount
  def has_excess_funds
    true if total_contributions > goal_amount
  end

  #
  # Updates project goal_amount when vendors are added/removed
  #
  def update_goal_amount
    @vendor_total = self.vendors.sum(:amount)
    self.update_attribute('goal_amount', @vendor_total)
  end

  #
  # Sends Compassion an email when there are no approved contractors available
  # for project
  #
  def notify_empty_contractors
    if nearby_contractors.blank?
      ProjectMailer.no_contractor_notification(self.user, self).deliver
    end
  end

end
