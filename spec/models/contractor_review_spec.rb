# == Schema Information
#
# Table name: contractor_reviews
#
#  id            :integer          not null, primary key
#  contractor_id :integer          not null
#  user_id       :integer          not null
#  rating        :integer
#  title         :string(60)       not null
#  comments      :text             not null
#  approved      :boolean          default(FALSE)
#  private       :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  project_id    :integer          not null
#

require 'spec_helper'

describe ContractorReview do
  pending "add some examples to (or delete) #{__FILE__}"
end
