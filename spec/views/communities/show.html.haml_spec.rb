require 'rails_helper'

RSpec.describe "communities/show", :type => :view do
  before(:each) do
    @community = assign(:community, Community.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
