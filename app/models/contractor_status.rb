# == Schema Information
#
# Table name: contractor_statuses
#
#  id         :integer          not null, primary key
#  text       :string(20)       not null
#  created_at :datetime
#  updated_at :datetime
#

class ContractorStatus < ActiveRecord::Base
end
