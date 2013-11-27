# == Schema Information
#
# Table name: updates
#
#  id         :integer          not null, primary key
#  project_id :integer          not null
#  body       :text             not null
#  facebook   :boolean          default(FALSE)
#  twitter    :boolean          default(FALSE)
#  email      :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Update do
  pending "add some examples to (or delete) #{__FILE__}"
end
