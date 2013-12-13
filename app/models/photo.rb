class Photo < ActiveRecord::Base
  attr_accessible :caption, :gallery_id, :image
  belongs_to :gallery

end
