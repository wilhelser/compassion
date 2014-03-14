# == Schema Information
#
# Table name: estimates
#
#  id          :integer          not null, primary key
#  project_id  :integer          not null
#  adjuster_id :integer          not null
#  amount      :decimal(8, 2)    default(0.0), not null
#  description :text
#  document    :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Estimate do
  pending "add some examples to (or delete) #{__FILE__}"
end
