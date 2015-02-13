require 'rails_helper'

RSpec.describe "hubs/edit", :type => :view do
  before(:each) do
    @hub = assign(:hub, Hub.create!(
      :name => "MyString",
      :description => "MyText",
      :latlng => ""
    ))
  end

  it "renders the edit hub form" do
    render

    assert_select "form[action=?][method=?]", hub_path(@hub), "post" do

      assert_select "input#hub_name[name=?]", "hub[name]"

      assert_select "textarea#hub_description[name=?]", "hub[description]"

      assert_select "input#hub_latlng[name=?]", "hub[latlng]"
    end
  end
end
