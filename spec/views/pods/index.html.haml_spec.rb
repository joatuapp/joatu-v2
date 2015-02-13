require 'rails_helper'

RSpec.describe "pods/index", :type => :view do
  before(:each) do
    assign(:pods, [
      Pod.create!(
        :name => "Name",
        :description => "MyText",
        :focus_area => "",
        :hub_id => 1
      ),
      Pod.create!(
        :name => "Name",
        :description => "MyText",
        :focus_area => "",
        :hub_id => 1
      )
    ])
  end

  it "renders a list of pods" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
