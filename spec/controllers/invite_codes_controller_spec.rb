require 'spec_helper'

describe InviteCodesController do

  describe "GET 'validate'" do
    it "returns http success" do
      get 'validate'
      response.should be_success
    end
  end

end
