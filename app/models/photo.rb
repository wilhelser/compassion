class Photo < ActiveRecord::Base
  include ImageMethods
  attr_accessible :caption, :gallery_id, :image, :key
  belongs_to :gallery, touch: true

  def image_url
    "https://s3.amazonaws.com/c4humanity/#{self.key}"
  end

  def set_key
    @image = self.image
    @key = get_s3_url(@image)
    self.update_attribute('key', @key)
  end

end
