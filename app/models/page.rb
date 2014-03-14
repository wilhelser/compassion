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
  extend FriendlyId
  friendly_id :title, use: :slugged
  attr_accessible :content, :title, :slug, :title_override
  validates :title, :content, presence: true
  validates_uniqueness_of :slug
end
