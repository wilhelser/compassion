require 'spec_helper'

describe Adjuster do
  it { should validate_presence_of(:email) }
  pending "it selects a new adjuster and sends notification out when assignment is declined"
end
