class Gallery < ActiveRecord::Base
  attr_accessible :description, :project_id, :contractor_id, :title
  belongs_to :contractor, touch: true
  belongs_to :project, touch: true
  has_many :photos, :dependent => :destroy

  def is_contractor_gallery?
    true unless self.contractor_id.nil?
  end

  def is_project_gallery?
    true unless self.project_id.nil?
  end
end
