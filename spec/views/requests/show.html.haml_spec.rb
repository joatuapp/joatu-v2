require 'rails_helper'

RSpec.describe "requests/show", :type => :view do
  before(:each) do
    @request = assign(:request, Request.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
