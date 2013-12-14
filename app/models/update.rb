class Update < ActiveRecord::Base
  include Koala
  attr_accessible :body, :email, :facebook, :project_id, :twitter, :title
  belongs_to :project, touch: true
  validates_presence_of :title, :body
  after_save :post_to_networks, on: :create
  # default_scope order('created_at DESC')

  def project
    Project.find(self.project_id)
  end

  def user
    project.user
  end

  def token
    user.token
  end

  def get_graph(token)
    Koala::Facebook::API.new(token)
  end

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

  def post_to_facebook
    @graph = get_graph(token)
    @graph.put_wall_post("I just posted an update to my project on Compassion for Humanity", { :name => "Update from my Compassion for Humanity Project", :description => "#{self.body}", :link => "http://compassionforhumanity.org/projects/#{project.id}"})
  end
end
