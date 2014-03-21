require "spec_helper"

describe BetaRequestsController do
  describe "routing" do

    it "routes to #index" do
      get("/beta_requests").should route_to("beta_requests#index")
    end

    it "routes to #new" do
      get("/beta_requests/new").should route_to("beta_requests#new")
    end

    it "routes to #show" do
      get("/beta_requests/1").should route_to("beta_requests#show", :id => "1")
    end

    it "routes to #edit" do
      get("/beta_requests/1/edit").should route_to("beta_requests#edit", :id => "1")
    end

    it "routes to #create" do
      post("/beta_requests").should route_to("beta_requests#create")
    end

    it "routes to #update" do
      put("/beta_requests/1").should route_to("beta_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/beta_requests/1").should route_to("beta_requests#destroy", :id => "1")
    end

  end
end
