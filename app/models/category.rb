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
  has_and_belongs_to_many :projects
  attr_accessible :name, :position, :description, :icon, :slug
  before_save :slugify
  validates_uniqueness_of :slug

  default_scope -> { order('position ASC') }

  def slugify
    self.slug = self.name.gsub(' ', '-').downcase
  end

  def to_s
    self.name
  end

  def to_param
    self.slug
  end

  # def self.find(input)
  #   input.to_i == 0 ? find_by_slug(input) : super
  # end
end
