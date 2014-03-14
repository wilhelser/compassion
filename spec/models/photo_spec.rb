# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  gallery_id :integer          not null
#  caption    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image      :string(255)      not null
#  key        :string(255)
#

require 'spec_helper'

describe Photo do
  pending "add some examples to (or delete) #{__FILE__}"
end
