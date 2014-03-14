# == Schema Information
#
# Table name: vendors
#
#  id             :integer          not null, primary key
#  project_id     :integer          not null
#  name           :string(100)      not null
#  amount         :decimal(8, 2)    not null
#  contact_name   :string(100)
#  address        :string(100)
#  city           :string(80)
#  state          :string(2)
#  zip_code       :integer
#  phone          :string(20)
#  invoice_number :string(100)
#  description    :text
#  documentation  :string(255)
#  verified       :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  due_date       :date
#  account_no     :string(255)
#  paid           :boolean          default(FALSE)
#

require 'spec_helper'

describe Vendor do
  pending "add some examples to (or delete) #{__FILE__}"
end
