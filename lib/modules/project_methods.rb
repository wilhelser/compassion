module ProjectMethods
  def send_funded_email

  end


  # Checks for inactive actions and sends an email
  # called from config/schedule.rb
  def email_inactive
    @projects = thirty_day_not_funded

  end

  def thirty_day_not_funded
    Project.where('created_at < ?', Date.today - 30.days)
  end
end
