# == Schema Information
#
# Table name: contractors
#
#  id                           :integer          not null, primary key
#  name                         :string(255)      not null
#  street_address               :string(255)      not null
#  city                         :string(255)      not null
#  state                        :string(255)      not null
#  zip_code                     :integer          not null
#  latitude                     :float
#  longitude                    :float
#  coverage_radius              :integer          default(25)
#  logo                         :string(255)
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  business_legal_name          :string(255)
#  business_dba_name            :string(255)
#  date_of_incorporation        :date
#  owner_first_name             :string(255)
#  owner_last_name              :string(255)
#  owner_phone                  :string(255)
#  owner_email                  :string(255)
#  mailing_address              :string(255)
#  mailing_address2             :string(255)
#  mailing_zip_code             :integer
#  mailing_city                 :string(255)
#  mailing_state                :string(255)
#  mailing_same                 :boolean
#  business_tax_id_no           :string(255)
#  ein                          :string(255)
#  number_of_employees          :integer
#  contractor_license_number    :string(255)
#  gross_annual_sales_last_year :string(255)
#  description                  :text
#  email                        :string(255)      default(""), not null
#  encrypted_password           :string(255)      default(""), not null
#  reset_password_token         :string(255)
#  reset_password_sent_at       :datetime
#  remember_created_at          :datetime
#  sign_in_count                :integer          default(0)
#  current_sign_in_at           :datetime
#  last_sign_in_at              :datetime
#  current_sign_in_ip           :string(255)
#  last_sign_in_ip              :string(255)
#  password_salt                :string(255)
#  confirmation_token           :string(255)
#  confirmed_at                 :datetime
#  confirmation_sent_at         :datetime
#  unconfirmed_email            :string(255)
#  authentication_token         :string(255)
#  status                       :string(255)      default("Not Submitted"), not null
#  terms                        :boolean
#  preferred                    :boolean          default(FALSE)
#  website_url                  :string(255)
#  slug                         :string(255)
#  gmaps                        :boolean
#  notify_on_select             :boolean          default(TRUE)
#  notify_on_review             :boolean          default(TRUE)
#  cell_phone                   :string(30)
#

require 'spec_helper'

describe Contractor do
  pending "add some examples to (or delete) #{__FILE__}"
end
