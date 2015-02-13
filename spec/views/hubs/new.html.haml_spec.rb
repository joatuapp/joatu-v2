require 'rails_helper'

RSpec.describe "hubs/new", :type => :view do
  before(:each) do
    assign(:hub, Hub.new(
      :name => "MyString",
      :description => "MyText",
      :latlng => ""
    ))
  end

  it "renders new hub form" do
    render

    assert_select "form[action=?][method=?]", hubs_path, "post" do

      assert_select "input#hub_name[name=?]", "hub[name]"

      assert_select "textarea#hub_description[name=?]", "hub[description]"

      assert_select "input#hub_latlng[name=?]", "hub[latlng]"
    end
  end
end
