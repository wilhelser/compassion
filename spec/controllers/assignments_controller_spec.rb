require 'spec_helper'

describe AssignmentsController do

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

end
