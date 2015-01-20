require 'rails_helper'

RSpec.describe "offers/index", :type => :view do
  before(:each) do
    assign(:offers, [
      Offer.create!(
        :title => "Title",
        :summary => "Summary",
        :description => "MyText"
      ),
      Offer.create!(
        :title => "Title",
        :summary => "Summary",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of offers" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Summary".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
