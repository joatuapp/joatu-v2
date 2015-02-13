require 'rails_helper'

RSpec.describe "pods/new", :type => :view do
  before(:each) do
    assign(:pod, Pod.new(
      :name => "MyString",
      :description => "MyText",
      :focus_area => "",
      :hub_id => 1
    ))
  end

  it "renders new pod form" do
    render

    assert_select "form[action=?][method=?]", pods_path, "post" do

      assert_select "input#pod_name[name=?]", "pod[name]"

      assert_select "textarea#pod_description[name=?]", "pod[description]"

      assert_select "input#pod_focus_area[name=?]", "pod[focus_area]"

      assert_select "input#pod_hub_id[name=?]", "pod[hub_id]"
    end
  end
end
