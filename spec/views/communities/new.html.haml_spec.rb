require 'rails_helper'

RSpec.describe "communities/new", :type => :view do
  before(:each) do
    assign(:community, Community.new(
      :name => "MyString"
    ))
  end

  it "renders new community form" do
    render

    assert_select "form[action=?][method=?]", communities_path, "post" do

      assert_select "input#community_name[name=?]", "community[name]"
    end
  end
end
