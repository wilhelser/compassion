# == Schema Information
#
# Table name: pages
#
#  id             :integer          not null, primary key
#  title          :string(255)      not null
#  content        :text             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  slug           :string(255)
#  title_override :string(255)
#

require 'spec_helper'

describe Page do
  pending "add some examples to (or delete) #{__FILE__}"
end
