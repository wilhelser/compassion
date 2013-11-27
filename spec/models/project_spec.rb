# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  goal_amount    :decimal(, )
#  page_title     :string(40)       not null
#  zip_code       :integer          not null
#  page_message   :text             not null
#  slug           :string(255)
#  approved       :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  featured_image :string(255)
#  featured_video :string(255)
#

require 'spec_helper'

describe Project do
  pending "add some examples to (or delete) #{__FILE__}"
end
