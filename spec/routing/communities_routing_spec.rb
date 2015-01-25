require "rails_helper"

RSpec.describe CommunitiesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/communities").to route_to("communities#index")
    end

    it "routes to #new" do
      expect(:get => "/communities/new").to route_to("communities#new")
    end

    it "routes to #show" do
      expect(:get => "/communities/1").to route_to("communities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/communities/1/edit").to route_to("communities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/communities").to route_to("communities#create")
    end

    it "routes to #update" do
      expect(:put => "/communities/1").to route_to("communities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/communities/1").to route_to("communities#destroy", :id => "1")
    end

  end
end
