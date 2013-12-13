class Project < ActiveRecord::Base
  include Koala
  extend FriendlyId
  include AutoHtml
  include ProjectMethods
  friendly_id :page_title, use: :slugged
  has_and_belongs_to_many :categories

  attr_accessible :approved, :goal_amount, :page_message, :page_title, :slug, :zip_code, :featured_image, :featured_video, :category_ids, :street_address, :city, :state, :latitude, :longitude, :user_id, :notify_on_donate, :private, :contractor_selection_attributes, :has_reviewed_contractor, :backer_count, :project_deadline, :reason_for_deadline, :funded, :funded_date, :galleries_attributes, :contributions_attributes, :funded_confirm
  validates :page_message, :page_title, :zip_code, :category_ids, :slug, presence: true
  validates_uniqueness_of :slug

  belongs_to :user
  has_many :updates, :dependent => :destroy
  has_many :contributions
  has_many :galleries, :dependent => :destroy
  has_many :contractor_selections, :dependent => :destroy
  has_many :contractors, :through => :contractor_selections
  has_many :vendors, :dependent => :destroy
  has_many :assignments, :dependent => :destroy
  has_many :estimates, :dependent => :destroy
  has_many :adjusters, :through => :estimates
  geocoded_by :address
  after_validation :geocode
  accepts_nested_attributes_for :galleries
  accepts_nested_attributes_for :contributions
  # after_create :post_to_compassion
  after_create :send_new_project_email

  scope :approved, where(:approved => true)
  scope :in_progress, where(:status => "In Progress")
  scope :funded, where(:funded => true)

  def address
    [street_address, city, state, zip_code].compact.join(', ')
  end

  def construction_project?
    self.category_ids.include?(8)
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

  def has_estimate?
    self.estimates.any?
  end

  def has_video?
    false if self.featured_video.blank? || self.featured_video.nil?
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
    self.category_ids.include?(8)
  end

  def needs_vendors
    true unless self.category_ids.include?(8)
  end

  def has_contractor
    if self.contractors.size == 0
      false
    else
      true
    end
  end

  def update_backer_count
    self.update_attribute('backer_count', self.contributions.length)
  end

  def long_link
    "http://compassionforhumanity.org/projects/#{self.slug}"
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
    self.public_contributions.last(10)
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

  def compassion_fb_page_id
    "583630311678418"
  end

  def post_to_compassion
    unless self.private?
      @graph = Koala::Facebook::API.new(compassion_access_token)
      @graph.put_wall_post("New project posted!", { :name => "#{self.page_title}", :description => "Description here", :link => "http://compassionforhumanity.org/projects/#{self.slug}"})
    end
  end

  def set_to_funded
    self.update_attribute('status', 'Funded')
    self.update_attribute('funded', true)
    unless self.construction_project?
      send_funded_email
    end
    # @graph = Koala::Facebook::API.new(compassion_access_token)
    # @graph.put_wall_post("Another Compassion project funded!", { :name => "#{self.page_title}", :description => "Funded!", :link => "http://compassionforhumanity.org/projects/#{self.slug}"})
  end

  def update_goal_amount
    @vendor_total = self.vendors.sum(:amount)
    self.update_attribute('goal_amount', @vendor_total)
  end

end
