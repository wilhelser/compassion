class Trade < ActiveRecord::Base
  has_and_belongs_to_many :contractors
  has_and_belongs_to_many :projects
  attr_accessible :name
end
