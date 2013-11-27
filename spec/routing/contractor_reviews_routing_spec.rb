require "spec_helper"

describe ContractorReviewsController do
  describe "routing" do

    it "routes to #index" do
      get("/contractor_reviews").should route_to("contractor_reviews#index")
    end

    it "routes to #new" do
      get("/contractor_reviews/new").should route_to("contractor_reviews#new")
    end

    it "routes to #show" do
      get("/contractor_reviews/1").should route_to("contractor_reviews#show", :id => "1")
    end

    it "routes to #edit" do
      get("/contractor_reviews/1/edit").should route_to("contractor_reviews#edit", :id => "1")
    end

    it "routes to #create" do
      post("/contractor_reviews").should route_to("contractor_reviews#create")
    end

    it "routes to #update" do
      put("/contractor_reviews/1").should route_to("contractor_reviews#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/contractor_reviews/1").should route_to("contractor_reviews#destroy", :id => "1")
    end

  end
end
