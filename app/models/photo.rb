# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  gallery_id :integer          not null
#  caption    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image      :string(255)      not null
#  key        :string(255)
#

class Photo < ActiveRecord::Base
  include ImageMethods
  attr_accessible :caption, :gallery_id, :image, :key
  validates_presence_of :image
  belongs_to :gallery
  after_create :set_key

  #
  # Builds the photo image url for display on the site
  #
  # @return [String] Full image URL
  def image_url
    "https://s3.amazonaws.com/c4humanity/#{self.key}"
  end

  #
  # calls get_s3_url in lib/modules/image_methods.rb and updates the key
  # attribute to the S3 bucket url for the image
  #
  # @return none
  def set_key
    @image = self.image
    @key = get_s3_url(@image)
    self.update_attribute('key', @key)
  end

end
