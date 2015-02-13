require 'rails_helper'

RSpec.describe "Hubs", :type => :request do
  describe "GET /hubs" do
    it "works! (now write some real specs)" do
      get hubs_path
      expect(response).to have_http_status(200)
    end
  end
end
