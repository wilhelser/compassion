class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_and_belongs_to_many :projects
  attr_accessible :name, :order, :description, :icon, :slug
  validates_uniqueness_of :slug

  def to_s
    self.name
  end
end
