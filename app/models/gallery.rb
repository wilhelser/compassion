class Gallery < ActiveRecord::Base
  attr_accessible :description, :project_id, :contractor_id, :title
  belongs_to :contractor
  belongs_to :project
  has_many :photos, :dependent => :destroy

end
