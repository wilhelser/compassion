class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  attr_accessible :content, :title, :slug
  validates :title, :content, presence: true
  validates_uniqueness_of :slug
end
