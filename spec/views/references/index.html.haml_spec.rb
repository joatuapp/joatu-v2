require 'rails_helper'

RSpec.describe "references/index", :type => :view do
  before(:each) do
    assign(:references, [
      Reference.create!(
        :from => "",
        :to => "",
        :reference => "MyText",
        :rating => 1,
        :offer => ""
      ),
      Reference.create!(
        :from => "",
        :to => "",
        :reference => "MyText",
        :rating => 1,
        :offer => ""
      )
    ])
  end

  it "renders a list of references" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
