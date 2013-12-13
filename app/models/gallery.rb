class Gallery < ActiveRecord::Base
  attr_accessible :description, :project_id, :contractor_id, :title
  belongs_to :contractor, touch: true
  belongs_to :project, touch: true
  has_many :photos, :dependent => :destroy

end
