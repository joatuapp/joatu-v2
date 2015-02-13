require 'rails_helper'

RSpec.describe "pods/edit", :type => :view do
  before(:each) do
    @pod = assign(:pod, Pod.create!(
      :name => "MyString",
      :description => "MyText",
      :focus_area => "",
      :hub_id => 1
    ))
  end

  it "renders the edit pod form" do
    render

    assert_select "form[action=?][method=?]", pod_path(@pod), "post" do

      assert_select "input#pod_name[name=?]", "pod[name]"

      assert_select "textarea#pod_description[name=?]", "pod[description]"

      assert_select "input#pod_focus_area[name=?]", "pod[focus_area]"

      assert_select "input#pod_hub_id[name=?]", "pod[hub_id]"
    end
  end
end
