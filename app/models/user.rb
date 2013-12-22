class User < ActiveRecord::Base
  extend FriendlyId
  include FriendsProjects
  friendly_id :username, use: :slugged
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me, :city, :state, :zip_code
  rolify
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook], :authentication_keys => [:login]

  has_many :projects, :dependent => :destroy
  has_many :contributions
  has_many :contractor_reviews
  attr_accessible :name, :email, :password, :username, :password_confirmation, :remember_me, :provider, :uid, :token, :login, :profile_image
  validates_uniqueness_of :username
  attr_accessor :login
  # after_create :set_user_location_and_username
  after_create :set_username

  # method to make the user show up nice in admin panel dropdowns
  def to_param
    username
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    Rails.logger.info auth
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           token:auth.credentials.token,
                           profile_image:auth.info.image,
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end

  def set_token(token)
    self.update_attribute('token', token)
  end

  def set_city(location)
    location.split(', ')[0]
  end

  # set username from Oath token
  def set_username
    unless self.token.nil?
      @graph = Koala::Facebook::API.new(self.token)
      @data = @graph.get_object('me')
      if @data['username'].nil?
        @username = self.email.gsub("@", "_").gsub(".", "_")
      else
        @username = @data['username'].gsub('.', '')
      end
      self.update_attribute('username', @username)
    end
  end

  # sets user state from location returned from FB Oath params
  def set_state(location)
    @state_name = location.split(', ')[1]
    ModelUN.convert(@state_name)
  end

  def can_manage_project(project)
    @project = project
    @project.user_id == self.id ? true : false
  end

  # authorization for user to edit a particular gallery
  # takes gallery as an argument
  # returns true or false
  def can_manage_gallery?(gallery)
    @project = gallery.project
    if @project.user_id == self.id
      return true
    else
      return false
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  # method to query a user's join date from their profile page
  def join_date
    self.created_at.strftime("%B %d, %Y")
  end

  def projects_in_progress
    self.projects.where(:status => "In Progress")
  end

  def first_name
    self.name.split(" ")[0]
  end

  def last_name
    self.name.split(" ")[1]
  end

  def facebook_image(w, h)
    "https://graph.facebook.com/#{self.uid}/picture?type=large"
  end
end
