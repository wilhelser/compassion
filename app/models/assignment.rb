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
    reassign_adjuster(self, project, adjuster)
  end

  def accept
    self.update_attribute('accepted', true)
    set_date_accepted
  end

  def self.created(a_date)
    return Assignment.where(created_at: to_timerange(a_date))
  end

  private

  def self.to_timerange(a_date)
    raise ArgumentError, "expected 'a_date' to be a Date" unless a_date.is_a? Date
    dts = Time.new(a_date.year, a_date.month, a_date.day, 0, 0, 0).utc
    dte = dts + (24 * 60 * 60) - 1
    return (dts...dte)
  end

  private

  def set_date_accepted
    self.date_accepted = Date.today
  end

end
