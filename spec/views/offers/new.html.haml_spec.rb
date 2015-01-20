require 'rails_helper'

RSpec.describe "offers/new", :type => :view do
  before(:each) do
    assign(:offer, Offer.new(
      :title => "MyString",
      :summary => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new offer form" do
    render

    assert_select "form[action=?][method=?]", offers_path, "post" do

      assert_select "input#offer_title[name=?]", "offer[title]"

      assert_select "input#offer_summary[name=?]", "offer[summary]"

      assert_select "textarea#offer_description[name=?]", "offer[description]"
    end
  end
end
