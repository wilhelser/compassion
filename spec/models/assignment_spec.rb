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

require 'spec_helper'

describe Assignment do
  pending "add some examples to (or delete) #{__FILE__}"
end
