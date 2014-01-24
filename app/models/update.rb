class Update < ActiveRecord::Base
  include Koala
  attr_accessible :body, :email, :facebook, :project_id, :twitter, :title
  belongs_to :project, touch: true
  validates_presence_of :title, :body
  after_save :post_to_networks, on: :create
  # default_scope order('created_at DESC')

  #
  # Project the update belongs to
  #
  # @return [Object] update's parent project
  def project
    Project.find(self.project_id)
  end

  #
  # User that owns project
  #
  # @return [Object] user that owns project
  def user
    project.user
  end

  #
  # User's FB token
  #
  # @return [String] user's FB token for publishing updates on their FB page
  def token
    user.token
  end

  #
  # Creates a new OpenGraph object
  # @param  token [String] user's FB token
  #
  # @return [object] new OpenGraph object
  def get_graph(token)
    Koala::Facebook::API.new(token)
  end

  #
  # Posts update to user's FB or Twitter profiles
  #
  def post_to_networks
    unless token.blank?
      if self.facebook?
        post_to_facebook
      end
      if self.twitter?
        post_to_twitter
      end
    end
  end

  #
  # Posts update to user's FB profile
  #
  def post_to_facebook
    @graph = get_graph(token)
    @graph.put_wall_post("I just posted an update to my project on Compassion for Humanity", { :name => "Update from my Compassion for Humanity Project", :description => "#{self.body}", :link => "http://compassionforhumanity.org/projects/#{project.id}"})
  end
end
