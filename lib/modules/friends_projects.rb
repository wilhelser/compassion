module FriendsProjects

  def get_friends_projects
    @users =  get_my_friends
    @projects = []
    @users.each do |u|
      proj = u.projects
      if proj.any?
        proj.each {|p| @projects << p }
      end
    end
    return @projects
  end

  def get_my_friends
    @graph = Koala::Facebook::API.new(self.token)
    @friends = @graph.get_connections('me', 'friends')
    @ids = []
    @friends.each {|f| @ids << f['id']}
    @users = []
    User.all.each {|u| @users << u if @ids.include?(u.uid) }
    return @users
  end

end
