# == Schema Information
#
# Table name: galleries
#
#  id            :integer          not null, primary key
#  project_id    :integer
#  title         :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  contractor_id :integer
#  gallery_type  :string(255)
#

require 'spec_helper'

describe Gallery do
  it "should increment project's gallery count by 1"
end
