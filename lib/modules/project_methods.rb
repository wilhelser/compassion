module ProjectMethods

  # sends email to action creator when action is funded
  # called from set_to_funded in Project model
  def send_funded_email
    ProjectMailer.project_funded_email(self.user, self).deliver
  end
end
