# == Schema Information
#
# Table name: donations
#
#  id                :integer          not null, primary key
#  amount            :decimal(8, 2)
#  name              :string(100)
#  zip_code          :integer
#  comments          :text
#  city              :string(60)
#  state             :string(2)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  stripe_card_token :string(255)
#  email             :string(255)
#

require 'spec_helper'

describe Donation do
  it "should be invalid without amount"

end
