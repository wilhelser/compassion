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
  attr_accessible :name, :email, :oops
end
