require "rails_helper"

RSpec.describe HubsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/hubs").to route_to("hubs#index")
    end

    it "routes to #new" do
      expect(:get => "/hubs/new").to route_to("hubs#new")
    end

    it "routes to #show" do
      expect(:get => "/hubs/1").to route_to("hubs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/hubs/1/edit").to route_to("hubs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/hubs").to route_to("hubs#create")
    end

    it "routes to #update" do
      expect(:put => "/hubs/1").to route_to("hubs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/hubs/1").to route_to("hubs#destroy", :id => "1")
    end

  end
end
