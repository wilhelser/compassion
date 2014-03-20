# == Schema Information
#
# Table name: contractor_statuses
#
#  id         :integer          not null, primary key
#  text       :string(20)       not null
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contractor_status do
    text "MyString"
  end
end
