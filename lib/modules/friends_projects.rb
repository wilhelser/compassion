module FriendsProjects

  #
  # Gets projects created by a user's friends
  #
  # @return [Array] projects created by user's friends
  def get_friends_projects
    @users =  get_my_friends(self.token)
    @projects = []
    @users.each do |u|
      proj = u.projects.approved
      if proj.any?
        proj.each {|p| @projects << p }
      end
    end
    return @projects
  end

  #
  # Get projects created by FB friends for non-logged in
  # or non-registered user
  # @param  token [String] Facebook authentication token
  #
  # @return [Array] projects created by FB friends
  def no_user_get_friends_projects(token)
    @token = token
    @users =  get_my_friends(token)
    @projects = []
    @users.each do |u|
      proj = u.projects.approved
      if proj.any?
        proj.each {|p| @projects << p }
      end
    end
    return @projects
  end

  #
  # Gets all FB friends that are Compassion users for logged-in
  # or non logged-in users
  # @param  token [String] FB authentication token
  #
  # @return [Array] all FB friends that are Compassion users
  def get_my_friends(token)
    @graph = Koala::Facebook::API.new(token)
    @friends = @graph.get_connections('me', 'friends')
    @ids = []
    @friends.each {|f| @ids << f['id']}
    @users = []
    User.all.each {|u| @users << u if @ids.include?(u.uid) }
    return @users
  end
end
