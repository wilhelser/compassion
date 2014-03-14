# == Schema Information
#
# Table name: trades
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Trade < ActiveRecord::Base
  has_and_belongs_to_many :contractors
  has_and_belongs_to_many :projects
  attr_accessible :name
end
