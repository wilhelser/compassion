# == Schema Information
#
# Table name: pages
#
#  id             :integer          not null, primary key
#  title          :string(255)      not null
#  content        :text             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  slug           :string(255)
#  title_override :string(255)
#

class Page < ActiveRecord::Base
  attr_accessible :content, :title, :slug, :title_override
  validates :title, :content, presence: true
  validates_uniqueness_of :slug
  before_create :slugify

  def slugify
    @slug = self.title.downcase.gsub(' ', '-')
    self.slug = @slug
  end

  def to_param
    self.slug
  end

  def self.find(input)
    input.to_i == 0 ? find_by_slug(input) : super
  end

end
