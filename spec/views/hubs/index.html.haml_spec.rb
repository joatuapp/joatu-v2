require 'rails_helper'

RSpec.describe "hubs/index", :type => :view do
  before(:each) do
    assign(:hubs, [
      Hub.create!(
        :name => "Name",
        :description => "MyText",
        :latlng => ""
      ),
      Hub.create!(
        :name => "Name",
        :description => "MyText",
        :latlng => ""
      )
    ])
  end

  it "renders a list of hubs" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
