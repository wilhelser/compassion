# == Schema Information
#
# Table name: beta_requests
#
#  id           :integer          not null, primary key
#  name         :string(60)       not null
#  email        :string(60)       not null
#  invited      :boolean          default(FALSE)
#  registered   :boolean          default(FALSE)
#  invited_date :date
#  oops         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe BetaRequest do
  pending "add some examples to (or delete) #{__FILE__}"
end
