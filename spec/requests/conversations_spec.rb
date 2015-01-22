require 'rails_helper'

RSpec.describe "Conversations", :type => :request do
  describe "GET /conversations" do
    it "works! (now write some real specs)" do
      get conversations_path
      expect(response).to have_http_status(200)
    end
  end
end
