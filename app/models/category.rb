# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  position    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  icon        :string(255)
#  slug        :string(80)
#

class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_and_belongs_to_many :projects
  attr_accessible :name, :position, :description, :icon, :slug
  validates_uniqueness_of :slug

  default_scope -> { order('position ASC') }

  def to_s
    self.name
  end
end
