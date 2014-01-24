class Gallery < ActiveRecord::Base
  attr_accessible :description, :project_id, :contractor_id, :title, :gallery_type
  belongs_to :contractor, touch: true
  belongs_to :project, touch: true
  has_many :photos

  #
  # Determines if gallery belongs to a contractor
  #
  # @return [Boolean] true if contractor_id is present
  def is_contractor_gallery?
    self.gallery_type == "contractor" ? true : false
  end

  #
  # Determines if gallery is project gallery
  #
  # @return [Boolean] true if project_id is present
  def is_project_gallery?
    self.gallery_type == "project" ? true : false
  end
end
