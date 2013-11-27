class Assignment < ActiveRecord::Base
  attr_accessible :adjuster_id, :project_id
  belongs_to :project
  belongs_to :adjuster
end
