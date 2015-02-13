require 'rails_helper'

RSpec.describe "hubs/show", :type => :view do
  before(:each) do
    @hub = assign(:hub, Hub.create!(
      :name => "Name",
      :description => "MyText",
      :latlng => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
