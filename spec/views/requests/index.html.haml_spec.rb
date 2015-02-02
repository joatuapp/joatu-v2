require 'rails_helper'

RSpec.describe "requests/index", :type => :view do
  before(:each) do
    assign(:requests, [
      Request.create!(),
      Request.create!()
    ])
  end

  it "renders a list of requests" do
    render
  end
end
