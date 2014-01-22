class Project < ActiveRecord::Base
  include Koala
  extend FriendlyId
  include AutoHtml
  include ProjectMethods
  include ImageMethods
  friendly_id :page_title, use: :slugged
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :trades

  attr_accessible :approved, :goal_amount, :page_message, :page_title, :slug, :zip_code, :featured_image, :featured_video, :category_ids, :street_address, :city, :state, :latitude, :longitude, :user_id, :notify_on_donate, :private, :contractor_selection_attributes, :has_reviewed_contractor, :backer_count, :project_deadline, :reason_for_deadline, :funded, :funded_date, :galleries_attributes, :contributions_attributes, :funded_confirm, :campaign_ended, :key, :trade_ids, :status, :campaign_ended_date, :campaign_extended_date
  validates :page_message, :page_title, :zip_code, :street_address, :city, :state, :category_ids, :slug, presence: true
  validates_uniqueness_of :slug
  validates_presence_of :featured_image, :if => lambda { self.featured_video.blank? }

  belongs_to :user, touch: true
  has_many :updates
  has_many :contributions
  has_many :galleries
  has_many :contractor_selections
  has_many :contractors, :through => :contractor_selections
  has_many :vendors
  has_many :assignments
  has_many :estimates
  has_many :adjusters, :through => :estimates
  geocoded_by :address
  after_validation :geocode
  accepts_nested_attributes_for :galleries
  accepts_nested_attributes_for :contributions
  before_save :set_key, :if => :featured_image_changed?
  before_save :set_video_key, :if => lambda { self.featured_video.present? }
  after_create :post_to_compassion
  after_create :send_new_project_email
  after_create :notify_empty_contractors

  scope :approved, -> { where(approved: true) }
  scope :in_progress, -> { where(status: 'In Progress') }
  scope :inactive, -> { where(approved: false) }
  scope :funded, -> { where(funded: true) }
  scope :complete, -> { where(campaign_ended: true) }
  scope :donatable, -> { where('goal_amount > ?', 0) }
  scope :extended, -> { where('campaign_extended_date != ?', nil) }

  #
  # Builds full address from project address fields
  #
  # @return String full project address for display on site
  def address
    [street_address, city, state, zip_code].compact.join(', ')
  end

  def stripped_content
    @body = self.page_message
    return ActionView::Base.full_sanitizer.sanitize(@body)
  end

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
  # @return boolan True if Action is in the Construction category ( 8 )
  def construction_project?
    self.category_ids.include?(4)
  end

  def needs_more_vendors
    if self.construction_project? || self.complete?
      false
    else
      self.has_excess_funds ? true :false
    end
  end

  def set_key
    unless featured_image.blank?
      @image = self.featured_image
      @key = get_s3_url(@image)
      self.key = @key
    end
  end

  def nearby_contractors
    Contractor.approved.near(self, 200)
  end

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

  def has_galleries?
    self.galleries.size > 0
  end

  def send_new_project_email
    ProjectMailer.new_project_user_email(self.user, self).deliver
  end

  def site_root
    if Rails.env == "development"
      "http://mnp.dev/"
    else
      "http://compassionforhumanity.org/"
    end
  end

  def total_contributions
    unless self.contributions.nil?
      self.contributions.sum(:amount)
    else
      0.00
    end
  end

  def to_s
    page_title
  end

  def has_deadline?
    self.project_deadline != nil
  end

  def complete?
    self.campaign_ended
  end

  def has_estimate?
    self.estimates.any?
  end

  def has_video?
    self.featured_video.present? ? true : false
  end

  auto_html_for :featured_video do
    html_escape
    image
    youtube(:width => 770, :height => 300)
    vimeo(:width => 770, :height => 300)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  def needs_contractor
    self.category_ids.include?(4)
  end

  def needs_vendors
    true unless self.category_ids.include?(4)
  end

  def has_contractor
    if self.contractors.size == 0
      false
    else
      true
    end
  end

  def qrcode
    "#{self.long_link}.png"
  end

  def update_backer_count
    self.update_attribute('backer_count', self.contributions.length)
  end

  def long_link
    "#{site_root}projects/#{self.slug}"
  end

  def public_contributions
    self.contributions.public
  end

  def can_accept_donations
    self.goal_amount > 0
  end

  def backer_count
    self.contributions.size
  end

  def recent_contributions
    self.contributions.last(10)
  end

  def percent_funded
    if self.goal_amount > 0
      self.total_contributions.to_f / self.goal_amount.to_f * 100.0
    else
      0.00
    end
  end

  def compassion_access_token
    "231408540317089|m8oArqgfDqwmu1yS38QjXDUtVvQ"
    # "289217204546185|SiM5nY_waJtkr9JjpeLBRluESNc" DEVELOPMENT
  end

  def compassion_page_access_token
    "CAADSdvZCX9aEBAN1dkD6B78ZAG1iA8UTKuspwdU0WnH1cNGOahUvxxo8ExZALWcltF4MuwD3L8k43TXDkzrXv8i5M3ZCZB3bKN7BO6bQg6krjOd2WOUrOPBN173XuulUkF2lDanjpVLCv3uKs8hBvhvmGC70gTZCAjtq6ayZBCZCleLhmJS4iZCC1"
  end

  def compassion_fb_page_id
    "583630311678418"
  end

  def post_to_compassion
    unless self.private?
      @graph = Koala::Facebook::API.new(compassion_page_access_token)
      @graph.put_wall_post("New Action posted!", { :name => "#{self.page_title}", :description => "Description here", :link => "http://compassionforhumanity.org/projects/#{self.slug}"})
    end
  end

  def has_excess_funds
    true if total_contributions > goal_amount
  end

  def update_goal_amount
    @vendor_total = self.vendors.sum(:amount)
    self.update_attribute('goal_amount', @vendor_total)
  end

  def notify_empty_contractors
    if nearby_contractors.blank?
      ProjectMailer.no_contractor_notification(self.user, self).deliver
    end
  end

end
