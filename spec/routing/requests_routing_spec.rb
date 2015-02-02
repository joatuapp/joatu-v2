require "rails_helper"

RSpec.describe RequestsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/requests").to route_to("requests#index")
    end

    it "routes to #new" do
      expect(:get => "/requests/new").to route_to("requests#new")
    end

    it "routes to #show" do
      expect(:get => "/requests/1").to route_to("requests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/requests/1/edit").to route_to("requests#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/requests").to route_to("requests#create")
    end

    it "routes to #update" do
      expect(:put => "/requests/1").to route_to("requests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/requests/1").to route_to("requests#destroy", :id => "1")
    end

  end
end
