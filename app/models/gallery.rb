class Gallery < ActiveRecord::Base
  attr_accessible :description, :project_id, :contractor_id, :title, :gallery_type
  belongs_to :contractor, touch: true
  belongs_to :project, touch: true
  has_many :photos

  def is_contractor_gallery?
    self.gallery_type == "contractor" ? true : false
  end

  def is_project_gallery?
    self.gallery_type == "project" ? true : false
  end
end
