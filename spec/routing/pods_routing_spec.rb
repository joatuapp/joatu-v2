require "rails_helper"

RSpec.describe PodsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pods").to route_to("pods#index")
    end

    it "routes to #new" do
      expect(:get => "/pods/new").to route_to("pods#new")
    end

    it "routes to #show" do
      expect(:get => "/pods/1").to route_to("pods#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pods/1/edit").to route_to("pods#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/pods").to route_to("pods#create")
    end

    it "routes to #update" do
      expect(:put => "/pods/1").to route_to("pods#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pods/1").to route_to("pods#destroy", :id => "1")
    end

  end
end
