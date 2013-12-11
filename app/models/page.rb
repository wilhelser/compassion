class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  attr_accessible :content, :title, :slug, :title_override
  validates :title, :content, presence: true
  validates_uniqueness_of :slug
end
