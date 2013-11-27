class Trade < ActiveRecord::Base
  has_and_belongs_to_many :contractors
  attr_accessible :name
end
