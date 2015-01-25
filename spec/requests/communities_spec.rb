require 'rails_helper'

RSpec.describe "Communities", :type => :request do
  describe "GET /communities" do
    it "works! (now write some real specs)" do
      get communities_path
      expect(response).to have_http_status(200)
    end
  end
end
