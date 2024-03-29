# == Schema Information
#
# Table name: beta_requests
#
#  id           :integer          not null, primary key
#  name         :string(60)       not null
#  email        :string(60)       not null
#  invited      :boolean          default(FALSE)
#  registered   :boolean          default(FALSE)
#  invited_date :date
#  oops         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class BetaRequest < ActiveRecord::Base
  include BetaRequestMethods
  attr_accessible :name, :email, :oops, :invited
  after_create :send_request_notification
  before_save :send_invitation, :if => lambda { self.invited? }

  scope :invited, -> { where(invited: true) }

  def send_invitation
    self.invited_date = Date.today
    BetaRequestNotifier.invitation_notifier(self).deliver
  end

  def send_request_notification
    BetaRequestNotifier.new_request_notifier(self).deliver
    subscribe_user_to_mailchimp(self)
  end

end
