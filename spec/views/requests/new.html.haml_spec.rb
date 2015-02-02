require 'rails_helper'

RSpec.describe "requests/new", :type => :view do
  before(:each) do
    assign(:request, Request.new())
  end

  it "renders new request form" do
    render

    assert_select "form[action=?][method=?]", requests_path, "post" do
    end
  end
end
