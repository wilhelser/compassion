# == Schema Information
#
# Table name: assignments
#
#  id            :integer          not null, primary key
#  project_id    :integer          not null
#  adjuster_id   :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  accepted      :boolean          default(FALSE)
#  date_accepted :date
#

class Assignment < ActiveRecord::Base
  include ContractorMethods
  attr_accessible :adjuster_id, :project_id, :accepted, :date_accepted
  belongs_to :project
  belongs_to :adjuster
  before_destroy :create_new_assignment

  scope :accepted, -> { where(accepted: true) }
  scope :needs_accepted, -> { where(accepted: false)}

  def create_new_assignment
    project = self.project
    adjuster = self.adjuster
    reassign_adjuster(project, adjuster)
  end

  def accept
    self.update_attribute('accepted', true)
    set_date_accepted
  end

  private

  def set_date_accepted
    self.date_accepted = Date.today
  end

end
