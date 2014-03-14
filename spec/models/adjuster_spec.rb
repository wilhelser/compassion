# == Schema Information
#
# Table name: adjusters
#
#  id                      :integer          not null, primary key
#  email                   :string(255)      default(""), not null
#  encrypted_password      :string(255)      default(""), not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  company                 :string(255)
#  first_name              :string(255)      not null
#  last_name               :string(255)      not null
#  phone                   :string(255)
#  fax                     :string(255)
#  street_address          :string(255)      not null
#  city                    :string(255)      not null
#  state                   :string(2)        not null
#  zip_code                :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  latitude                :float
#  longitude               :float
#  approved                :boolean          default(FALSE)
#  cell_phone              :string(255)
#  state_licensed_in       :text
#  license_number          :string(255)
#  date_license_issued     :date
#  license_expiration_date :date
#  license                 :string(255)
#  notify_on_assignment    :boolean          default(TRUE)
#

require 'spec_helper'

describe Adjuster do
  it { should validate_presence_of(:email) }
  pending "it selects a new adjuster and sends notification out when assignment is declined"
end
