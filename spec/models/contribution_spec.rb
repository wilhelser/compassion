# == Schema Information
#
# Table name: contributions
#
#  id                :integer          not null, primary key
#  project_id        :integer          not null
#  amount            :decimal(8, 2)    default(0.0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  comments          :text
#  stripe_card_token :string(255)
#  private           :boolean          default(FALSE)
#  address           :string(255)
#  address_2         :string(255)
#  city              :string(255)
#  email             :string(255)
#  first_name        :string(255)
#  last_name         :string(255)
#  image             :string(255)
#  state             :string(2)
#  zip_code          :string(5)
#

require 'spec_helper'

describe Contribution do
  pending "add some examples to (or delete) #{__FILE__}"
end
